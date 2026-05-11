import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modul_10/app/data/user_model.dart';
import 'package:modul_10/app/routes/app_pages.dart' show Routes;
import 'package:modul_10/services/auth_api.dart';

class StartController extends GetxController {
  UserModel? userModel;
  final box = GetStorage();
  bool startScreen = false;
  Future<void> autoLogin() async {
    startScreen = false;
    update();
    if (box.hasData("token") == true) {
      userModel = await AuthApi().checkTokenApi(box.read("token"));
      if (userModel!.status == 200) {
        Get.offAndToNamed(Routes.HOME);
      } else if (userModel!.status == 404) {
        startScreen = true;
        update();
      } else if (userModel!.status == 401) {
        box.remove("token");
        box.remove("id");
        Get.offAndToNamed(Routes.LOGIN);
      } else {
        box.remove("token");
        box.remove("id");
        Get.offAndToNamed(Routes.LOGIN);
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}
