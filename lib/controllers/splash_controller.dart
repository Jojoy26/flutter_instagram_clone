import 'package:dio/dio.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/secure_storage_controller.dart';
import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';

class SplashController extends GetxController with HttpClient {

  final SecureStorageController storageController;
  final UserController userController;
  SplashController({
    required this.storageController,
    required this.userController,
  });

  Future verifyToken() async {
    await Future.delayed(Duration(seconds: 2));
    late String token;
    try{
      String? result = await getToken();
      print(result);
      if(result == null){
        Get.offAllNamed("/login",);
        return;
      } else {
        token = result;
      }
    } catch(e){
      Get.offAllNamed("/login");
      return;
    }

    try {
      final result = await callApi(RequestTypes.get, "/user", null, {"x-auth-token": token});
      print(result!.data);
      UserModel user = UserModel.fromMap(result.data);
      userController.setToken(token);
      userController.setUser(user);
      Get.offAllNamed("/bottomNavigation");
    } on DioError catch(e){
      await storageController.delete();
      Get.offAllNamed("/login");
    }

  }

  Future<String?> getToken() async {
    
    String? result = await storageController.read();
    return result;
  }

}
