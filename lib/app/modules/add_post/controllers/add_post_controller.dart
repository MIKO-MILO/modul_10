import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modul_10/app/data/post_model.dart';
import 'package:modul_10/app/routes/app_pages.dart';
import 'package:modul_10/services/post_api.dart';

class AddPostController extends GetxController {
  PostModel? postModel;
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();

  RxString selectedCategory = "Travel".obs;
  Rx<XFile?> imageFile = Rx<XFile?>(null);
  final ImagePicker picker = ImagePicker();

  final List<String> categories = [
    "Travel",
    "Business",
    "Sports",
    "Politics",
    "Health",
  ];

  @override
  void onClose() {
    titleC.dispose();
    contentC.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile.value = image;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengambil gambar. Silakan restart aplikasi secara penuh.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addPost() async {
    if (titleC.text.isEmpty || contentC.text.isEmpty) {
      Get.snackbar("Error", "Judul dan konten wajib diisi");
      return;
    }

    isLoading.value = true;
    update();

    try {
      postModel = await PostApi().addPostAPI(
        titleC.text,
        contentC.text,
        selectedCategory.value,
        imageFile.value,
      );

      if (postModel?.status == 200) {
        Get.snackbar("Sukses", "Berhasil menambah postingan");
        Get.offAndToNamed(Routes.HOME);
      } else {
        Get.snackbar("Error", "Gagal menambah postingan");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
