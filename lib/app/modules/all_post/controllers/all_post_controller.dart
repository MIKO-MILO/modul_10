import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modul_10/app/data/post_model.dart';
import 'package:modul_10/services/post_api.dart';
import 'package:modul_10/widget/loading.dart';

class AllPostController extends GetxController {
  PostListModel? posts;
  final box = GetStorage();
  bool homeScreen = false;
  Future<void> loadPost() async {
    homeScreen = false;
    update();
    showLoading();
    posts = await PostApi().loadPostAPI();
    update();
    stopLoading();
    if (posts?.status == 200) {
    } else if (posts!.status == 204) {
    } else if (posts!.status == 404) {
      homeScreen = true;
      update();
    } else if (posts!.status == 401) {
    } else {}
  }

  Future<void> deletePost(String id) async {
    await PostApi().deletePostAPI(id);
  }
}
