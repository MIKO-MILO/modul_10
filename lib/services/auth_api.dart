import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:modul_10/app/data/user_model.dart';
import 'package:modul_10/utils/api.dart';
import 'package:modul_10/widget/message/error_message.dart';
import 'package:modul_10/widget/message/internet_message.dart';

class AuthApi extends SharedApi {
  void showLoading() {
    BotToast.showLoading();
  }

  void stopLoading() {
    BotToast.closeAllLoading();
  }

  // Login API
  Future<UserModel?> loginAPI(String email, String password) async {
    try {
      showLoading();
      var data = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );
      stopLoading();
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        return UserModel.fromJson(jsonData);
      } else {
        showErrorMessage(jsonData['message'] ?? "Gagal Login");
        return UserModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status": 404});
    }
  }

  // Check Token API
  Future<UserModel?> checkTokenApi(String token) async {
    try {
      var headers = {"Authorization": "Bearer $token"};
      showLoading();
      var data = await http.get(Uri.parse('$baseUrl/user'), headers: headers);
      stopLoading();
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['status'] = 200;
        jsonData['access_token'] = token;
        jsonData['token_type'] = "bearer";
        return UserModel.fromJson(jsonData);
      } else if (data.statusCode == 401) {
        showErrorMessage(jsonData['message']);
        return UserModel.fromJson({"status": data.statusCode});
      } else {
        showErrorMessage("Ada yang salah");
        return UserModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status": 404});
    }
  }

  // Register API
  Future<UserModel?> registerAPI(
    String name,
    String email,
    String password,
  ) async {
    try {
      showLoading();
      var data = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );
      stopLoading();
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        return UserModel.fromJson(jsonData);
      } else {
        showErrorMessage(jsonData['message'] ?? "Gagal Registrasi");
        return UserModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status": 404});
    }
  }
}
