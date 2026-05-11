import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:modul_10/app/data/user_model.dart';
import 'package:modul_10/app/routes/app_pages.dart';
import 'package:modul_10/services/auth_api.dart';

class LoginController extends GetxController {
  UserModel? userModel;
  final box = GetStorage();
  bool loginScreen = false;
  RxBool isLoading = false.obs;
  RxBool obscureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  Future<void> login() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      Get.snackbar("Error", "Email dan password harus diisi");
      return;
    }
    isLoading.value = true;
    update();
    try {
      userModel = await AuthApi().loginAPI(emailC.text, passC.text);
      if (userModel != null && userModel!.status == 200) {
        await box.write("token", userModel!.accessToken);
        await box.write("name", userModel!.name);
        await box.write("email", userModel!.email);
        Get.offAndToNamed(Routes.HOME);
      } else {
        loginScreen = true;
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
