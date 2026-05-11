import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul_10/app/data/post_model.dart';
import 'package:modul_10/app/routes/app_pages.dart';
import 'package:modul_10/utils/app_color.dart';
import 'package:modul_10/widget/auto_load.dart';
import 'package:modul_10/widget/no_data.dart';
import 'package:modul_10/widget/no_network.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => AutoLoad(
        onInit: () async {
          await controller.loadPost();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          body: Obx(() {
            if (controller.isInitialLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return controller.homeScreen == false
                ? SafeArea(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      children: [
                        // Header Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "NEWZIA",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                                color: AppColor.darkBlue,
                              ),
                            ),
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ),
                                Positioned(
                                  right: 12,
                                  top: 12,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: AppColor.accentRed,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Featured Card Section (Post Utama)
                        Builder(
                          builder: (context) {
                            // Selalu ambil dari allPosts agar tidak terpengaruh filter
                            // Jika allPosts kosong, gunakan data dummy
                            var featured =
                                (controller.allPosts != null &&
                                    controller.allPosts!.items != null &&
                                    controller.allPosts!.items!.isNotEmpty)
                                ? controller.allPosts!.items![0]
                                : PostModel(
                                    id: "dummy",
                                    title: "Selamat Datang di POSTS App",
                                    content:
                                        "Mulai tulis dan bagikan berita menarik Anda hari ini di platform kami.",
                                    category: "Travel",
                                    image:
                                        "https://images.unsplash.com/photo-1504711434969-e33886168f5c?auto=format&fit=crop&q=80&w=1000",
                                  );

                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_POST,
                                  arguments: {
                                    "id": featured.id,
                                    "title": featured.title,
                                    "content": featured.content,
                                    "category": featured.category,
                                    "image": featured.image,
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                height: 380,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  image: DecorationImage(
                                    image: featured.image != null
                                        ? NetworkImage(featured.image!)
                                        : const NetworkImage(
                                            "https://images.unsplash.com/photo-1504711434969-e33886168f5c?auto=format&fit=crop&q=80&w=1000",
                                          ),
                                    fit: BoxFit.cover,
                                    onError: (exception, stackTrace) {},
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withAlpha(
                                          (0.8 * 255).toInt(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              featured.category ?? "Post",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "5 min read",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        featured.title ?? "-",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    AppColor.primary,
                                                child: ClipOval(
                                                  child: Image.network(
                                                    "https://ui-avatars.com/api/?name=Admin",
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => const Icon(
                                                          Icons.person,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "Admin News",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "3 hours ago",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              if (featured.id != "dummy")
                                                PopupMenuButton<String>(
                                                  icon: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.white,
                                                  ),
                                                  onSelected: (value) {
                                                    if (value == 'edit') {
                                                      Get.toNamed(
                                                        Routes.EDIT_POST,
                                                        arguments: {
                                                          "id": featured.id,
                                                          "title":
                                                              featured.title,
                                                          "content":
                                                              featured.content,
                                                          "category":
                                                              featured.category,
                                                          "image":
                                                              featured.image,
                                                        },
                                                      );
                                                    } else if (value ==
                                                        'delete') {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          title: const Text(
                                                            "Hapus Post",
                                                          ),
                                                          content: const Text(
                                                            "Apakah anda yakin ingin menghapus postingan ini?",
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              child: const Text(
                                                                "Batal",
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                                controller
                                                                    .deletePost(
                                                                      featured
                                                                          .id
                                                                          .toString(),
                                                                    );
                                                              },
                                                              child: const Text(
                                                                "Hapus",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  itemBuilder: (context) => [
                                                    const PopupMenuItem(
                                                      value: 'edit',
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.edit,
                                                            size: 18,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text("Edit"),
                                                        ],
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: 'delete',
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.delete,
                                                            size: 18,
                                                            color: Colors.red,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            "Hapus",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Category Filter Section
                        SizedBox(
                          height: 40,
                          child: Obx(
                            () => ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildCategoryChip("Latest"),
                                _buildCategoryChip("Business"),
                                _buildCategoryChip("Sports"),
                                _buildCategoryChip("Politics"),
                                _buildCategoryChip("Health"),
                                _buildCategoryChip("Travel"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // List Post Section
                        Builder(
                          builder: (context) {
                            if (controller.posts == null ||
                                controller.posts!.status != 200 ||
                                controller.posts!.items == null) {
                              return NoData();
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.posts?.items?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                // Ambil postData langsung berdasarkan index dari controller.posts!.items
                                var postData = controller.posts!.items![index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.DETAIL_POST,
                                      arguments: {
                                        "id": postData.id,
                                        "title": postData.title,
                                        "content": postData.content,
                                        "category": postData.category,
                                        "image": postData.image,
                                      },
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          postData.image ??
                                              "https://images.unsplash.com/photo-1495020689067-958852a7765e?auto=format&fit=crop&q=80&w=200",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    color: AppColor.lightGray,
                                                    child: const Icon(
                                                      Icons.image,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${postData.category ?? 'Business'} • 12 min read",
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: AppColor.secondarySoft,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              postData.title ?? "-",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.darkBlue,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "1 min ago",
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: AppColor.secondarySoft,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Tambahkan tombol Delete & Edit
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            Get.toNamed(
                                              Routes.EDIT_POST,
                                              arguments: {
                                                "id": postData.id,
                                                "title": postData.title,
                                                "content": postData.content,
                                                "category": postData.category,
                                                "image": postData.image,
                                              },
                                            );
                                          } else if (value == 'delete') {
                                            Get.dialog(
                                              AlertDialog(
                                                title: const Text("Hapus Post"),
                                                content: const Text(
                                                  "Apakah anda yakin ingin menghapus postingan ini?",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Get.back(),
                                                    child: const Text("Batal"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                      controller.deletePost(
                                                        postData.id.toString(),
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Hapus",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit, size: 18),
                                                SizedBox(width: 8),
                                                Text("Edit"),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Hapus",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  )
                : NoNetwork(onInit: () => controller.loadPost());
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_POST);
            },
            backgroundColor: AppColor.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          bottomNavigationBar: _buildBottomNav(),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isActive = controller.selectedCategory.value == label;
    return InkWell(
      onTap: () => controller.filterByCategory(label),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColor.darkBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: isActive ? Colors.white : AppColor.secondarySoft,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Obx(
      () => Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, "Home", 0),
            _buildNavItem(Icons.search, "Search", 1),
            _buildNavItem(Icons.newspaper, "Berita", 2),
            _buildNavItem(Icons.logout_rounded, "Logout", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = controller.currentIndex.value == index;
    return InkWell(
      onTap: () {
        if (index == 2) {
          Get.toNamed(Routes.ALL_POST);
          return;
        }
        controller.currentIndex.value = index;
        if (index == 3) {
          // Jika klik profile, tampilkan modal logout
          controller.logout();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColor.accentRed : AppColor.secondarySoft,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? AppColor.accentRed : AppColor.secondarySoft,
            ),
          ),
        ],
      ),
    );
  }
}
