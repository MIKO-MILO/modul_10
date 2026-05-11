import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:modul_10/app/data/post_model.dart';
import 'package:modul_10/utils/api.dart';
import 'package:modul_10/widget/message/error_message.dart';
import 'package:modul_10/widget/message/internet_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class PostApi extends SharedApi {
  void showLoading() {
    BotToast.showLoading();
  }

  void stopLoading() {
    BotToast.closeAllLoading();
  }

  // Login API
  Future<PostListModel> loadPostAPI() async {
    try {
      var data = await http.get(
        Uri.parse('${baseUrl.replaceAll('/auth', '/api')}/posts'),
        headers: getToken(),
      );
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        return PostListModel.fromJson({
          "status": 200,
          "items": jsonData['data'],
        });
      } else {
        return PostListModel.fromJson({"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return PostListModel.fromJson({"status": 404, "items": []});
    }
  }

  Future<PostModel?> addPostAPI(
    String title,
    String content,
    String category,
    XFile? imageFile,
  ) async {
    try {
      showLoading();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseUrl.replaceAll('/auth', '/api')}/posts'),
      );
      request.headers.addAll(getToken());
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['category'] = category;

      if (imageFile != null) {
        if (kIsWeb) {
          var bytes = await imageFile.readAsBytes();
          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              bytes,
              filename: imageFile.name,
            ),
          );
        } else {
          request.files.add(
            await http.MultipartFile.fromPath('image', imageFile.path),
          );
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      stopLoading();

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        return PostModel.fromJson(jsonData['data']);
      } else {
        showErrorMessage(jsonData['message'] ?? "Gagal menambahkan post");
        return PostModel.fromJson({"status": response.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PostModel.fromJson({"status": 404});
    }
  }

  Future<PostModel?> editPostAPI(
    String title,
    String content,
    String id,
    String category,
    XFile? newImage,
    String? oldImageUrl,
  ) async {
    try {
      showLoading();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseUrl.replaceAll('/auth', '/api')}/posts/$id'),
      );
      request.headers.addAll(getToken());
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['category'] = category;

      if (newImage != null) {
        // Jika ada gambar baru yang dipilih
        if (kIsWeb) {
          var bytes = await newImage.readAsBytes();
          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              bytes,
              filename: newImage.name,
            ),
          );
        } else {
          request.files.add(
            await http.MultipartFile.fromPath('image', newImage.path),
          );
        }
      } else if (oldImageUrl != null) {
        // Jika tidak ada gambar baru, kirim URL gambar lama agar tetap ada di database
        request.fields['image'] = oldImageUrl;
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      stopLoading();

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        return PostModel.fromJson(jsonData['data']);
      } else {
        showErrorMessage(jsonData['message'] ?? "Gagal mengedit post");
        return PostModel.fromJson({"status": response.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PostModel.fromJson({"status": 404});
    }
  }

  Future<PostModel?> deletePostAPI(String id) async {
    try {
      showLoading();
      var response = await http.delete(
        Uri.parse('${baseUrl.replaceAll('/auth', '/api')}/posts/$id'),
        headers: getToken(),
      );
      stopLoading();
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        var postData = <String, dynamic>{};
        postData["status_code"] = 200;
        return PostModel.fromJson(postData);
      } else {
        showErrorMessage(jsonData['message'] ?? "Gagal menghapus post");
        return PostModel.fromJson({"status": response.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PostModel.fromJson({"status": 404});
    }
  }
}
