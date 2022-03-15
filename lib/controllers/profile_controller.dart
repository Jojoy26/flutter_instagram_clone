import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/secure_storage_controller.dart';
import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/models/user_search_model.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';

class ProfileController extends GetxController with HttpClient, SnackBar {

  final UserController userController;
  final SecureStorageController storageController;
  ProfileController({
    required this.userController,
    required this.storageController,
  });

  RxList<String> postsList = <String>[].obs;
  Rx<UserModel>? user;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;

  Future getUserInfos(String username) async {
    try {
      final result = await callApi(RequestTypes.get, "/user/${username}", null, userController.currentToken.toMap());
      final userFromMap = UserModel.fromMap(result!.data).obs;

      if(user != null){
        user!.value = UserModel.fromMap(result.data);
      } else {
        user = UserModel.fromMap(result.data).obs;
      }
      
    } on DioError catch(e){
      isLoading.value = false;
      if(user == null){
        hasError.value = true;
      }
    }
  }

  Future getPhotos(String username) async {
    try {
      final result = await callApi(RequestTypes.get, "/user/posts/${username}", null, userController.currentToken.toMap());
      List<String> list = List<String>.from(result!.data);
      print(list);
      postsList.value = list;
    } on DioError catch(e){
      isLoading.value = false;
      if(user == null){
        hasError.value = true;
      }
    }
  }

  Future getAll(UserSearchModel? user) async {

    String username = userController.currentUserModel.username;
    if(user != null){
      username = user.username;
    }

    isLoading.value = true;
    hasError.value = false;
    await getUserInfos(username);
    if(hasError.value) return;
    await getPhotos(username);
    isLoading.value = false;
  }

  Future toggleFollow(String username) async {
    try{
      final result = await callApi(RequestTypes.post, "/user/follow/",{"username": username}, userController.currentToken.toMap());
      getUserInfos(username);
    } on DioError catch(e){

    }
  }

  Future signOut() async {
    try{
      await storageController.delete();
      Get.offAllNamed("/login");
    } catch(e){
      Get.offAllNamed("/login");
    }
  }
}
