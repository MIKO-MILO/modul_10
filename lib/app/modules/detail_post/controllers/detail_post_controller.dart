import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul_10/app/data/post_model.dart';
import 'package:modul_10/app/routes/app_pages.dart';
import 'package:modul_10/services/post_api.dart';
import 'package:modul_10/widget/custom_alert_dialog.dart';

class DetailPostController extends GetxController {
  final Map<String, dynamic> argsData = Get.arguments ?? {};
  PostModel? postModel;
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();

  @override
  void onClose() {
    titleC.dispose();
    contentC.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    titleC.text = argsData["title"] ?? "";
    contentC.text = argsData["content"] ?? "";
  }

  Future<void> deletePost() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data todo",
      message: "Apakah anda ingin menghapus data todo ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        Get.back(); // close modal
        update();
        if (argsData["id"] == null) {
          Get.snackbar("Error", "ID postingan tidak ditemukan");
          return;
        }
        postModel = await PostApi().deletePostAPI(argsData["id"].toString());
        if (postModel?.status == 200) {
          update();
          Get.offAndToNamed(Routes.HOME);
        }
      },
    );
  }
}
