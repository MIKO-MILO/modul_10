import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul_10/app/routes/app_pages.dart';
import 'package:modul_10/utils/app_color.dart';
import 'package:modul_10/utils/time_helper.dart';
import 'package:modul_10/widget/auto_load.dart';
import 'package:modul_10/widget/no_data.dart';

import '../controllers/all_post_controller.dart';

class AllPostView extends GetView<AllPostController> {
  const AllPostView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllPostController>(
      builder: (controller) => AutoLoad(
        onInit: () async {
          await controller.loadPost();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Semua Data Post',
              style: GoogleFonts.poppins(
                color: AppColor.secondary,
                fontSize: 14,
              ),
            ),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back, color: AppColor.secondary),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColor.secondaryExtraSoft,
              ),
            ),
          ),
          body: GetBuilder<AllPostController>(
            builder: (controller) =>
                controller.posts != null &&
                    controller.posts!.status == 200 &&
                    controller.posts!.items != null
                ? ListView.separated(
                    itemCount: controller.posts!.items!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
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
                              "createdAt": postData.createdAt,
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
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 100,
                                      height: 100,
                                      color: AppColor.lightGray,
                                      child: const Icon(Icons.image),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${postData.category ?? 'General'} • ${TimeHelper.calculateReadTime(postData.content)}",
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
                                    TimeHelper.timeAgo(postData.createdAt),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: AppColor.secondarySoft,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                            style: TextStyle(color: Colors.red),
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
                                        style: TextStyle(color: Colors.red),
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
                  )
                : NoData(),
          ),
        ),
      ),
    );
  }
}
