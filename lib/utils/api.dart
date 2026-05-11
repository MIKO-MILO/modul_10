import 'package:get_storage/get_storage.dart';

class SharedApi {
  String imageUrl = "http://posts.doyatama.com";
  String baseUrl = "https://flutter-api-three-amber.vercel.app/auth";

  // Helper untuk membungkus URL dengan proxy CORS jika di Web
  String wrapProxy(String url) {
    return url;
  }

  Map<String, String> getToken() {
    final box = GetStorage();
    String? token = box.read("token");
    Map<String, String> headers = {"Accept": "application/json"};
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    } else {
      headers["Authorization"] = "Bearer BadToken";
    }
    return headers;
  }
}
