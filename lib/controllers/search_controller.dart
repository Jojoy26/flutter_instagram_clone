import 'package:dio/dio.dart';
import 'package:flutter_instagram/models/user_search_model.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';

class SearchController extends GetxController with HttpClient, SnackBar {

  final UserController userController;

  SearchController({
    required this.userController,
  });

  RxList<UserSearchModel> usersList = <UserSearchModel>[].obs;
  RxBool isLoading = false.obs;

  Future getUsersBySearch(String search) async {

    if(search == ""){
      errorSnackBar("Type some name");
      return;
    }
    isLoading.value = true;
    try {
      final result = await callApi(RequestTypes.get, "/user/search/${search}", null, userController.currentToken.toMap());
      List<UserSearchModel> list = (result!.data as List).map((e) => UserSearchModel.fromMap(e)).toList();
      usersList.value = list;
      isLoading.value = false;
    } on DioError catch(e){
      isLoading.value = false;
      errorSnackBar("Failed to search users");
    }

  }

  void goToProfile(UserSearchModel user) {
    Get.toNamed("/profile", arguments: {"user": user});
  }

}
