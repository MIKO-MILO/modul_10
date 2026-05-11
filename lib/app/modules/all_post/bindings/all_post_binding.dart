import 'package:get/get.dart';

import '../controllers/all_post_controller.dart';

class AllPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPostController>(
      () => AllPostController(),
    );
  }
}
