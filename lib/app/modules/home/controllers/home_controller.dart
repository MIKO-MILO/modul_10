import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul_10/app/data/post_model.dart';
import 'package:modul_10/app/routes/app_pages.dart';
import 'package:modul_10/services/post_api.dart';
import 'package:modul_10/utils/app_color.dart';

class HomeController extends GetxController {
  PostListModel? posts;
  PostListModel? allPosts; // Simpan semua post untuk filter
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isInitialLoading = true.obs;
  RxString selectedCategory = "Latest".obs;
  RxInt currentIndex = 0.obs;

  Future<void> loadPost() async {
    homeScreen = false;
    allPosts = await PostApi().loadPostAPI();
    posts = allPosts;
    isInitialLoading.value = false;

    // Terapkan filter jika ada kategori yang dipilih selain Latest
    if (selectedCategory.value != "Latest") {
      filterByCategory(selectedCategory.value);
    }

    update();
    if (posts?.status == 404) {
      homeScreen = true;
      update();
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (allPosts != null && allPosts!.items != null) {
      if (category == "Latest") {
        posts = allPosts;
      } else {
        var filteredItems = allPosts!.items!
            .where(
              (post) => post.category?.toLowerCase() == category.toLowerCase(),
            )
            .toList();
        posts = PostListModel(status: allPosts!.status, items: filteredItems);
      }
    }
    update();
  }

  Future<void> deletePost(String id) async {
    try {
      var res = await PostApi().deletePostAPI(id);
      if (res?.status == 200) {
        Get.snackbar("Sukses", "Berhasil menghapus postingan");
        await loadPost(); // Refresh data
      } else {
        Get.snackbar("Error", "Gagal menghapus postingan");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  Future<void> logout() async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.accentRed.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: AppColor.accentRed,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Logout System",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColor.darkBlue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Apakah anda yakin ingin keluar dari akun Anda?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColor.secondarySoft,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: AppColor.secondaryExtraSoft),
                        ),
                      ),
                      child: Text(
                        "Batal",
                        style: GoogleFonts.poppins(
                          color: AppColor.secondarySoft,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back(); // close modal
                        try {
                          box.remove("token");
                          box.remove("name");
                          box.remove("email");
                          await Get.offAllNamed(Routes.LOGIN);
                        } catch (e) {
                          Get.snackbar("Error", "Gagal logout: $e");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accentRed,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Logout",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
