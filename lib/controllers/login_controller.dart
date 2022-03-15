import 'package:dio/dio.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/secure_storage_controller.dart';
import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';

class LoginController extends GetxController with HttpClient, SnackBar {
  
  final SecureStorageController storageController;
  final UserController userController;

  LoginController({
    required this.storageController,
    required this.userController,
  });

  String email = "";
  String password = "";

  void goToSignUp(){
    Get.offAllNamed("/signup");
  }

  Future login() async {
    try {
      final result = await callApi(RequestTypes.post, "/signin", {
        "email": email,
        "password": password
      }, null);
      sucessSnackBar("Login successfully");
      print(result);
      await storageController.save(result!.data["token"]);

      final userInfos = await getUserInfos(result.data["token"]);

      userController.setToken(result.data["token"]);
      userController.setUser(userInfos);

      Get.offAllNamed("/bottomNavigation");
    } on DioError catch(e){
      if(e.response == null){
        errorSnackBar("Failed to login");
        return;
      }
      if(e.response!.statusCode != 200){
        errorSnackBar(e.response!.data["msg"]);
        return;
      }
      
    }
  }

  Future<UserModel> getUserInfos(String token) async {
    final result = await callApi(RequestTypes.get, "/user", null, {"x-auth-token": token});
    UserModel user = UserModel.fromMap(result!.data);
    return user;
  }

}
