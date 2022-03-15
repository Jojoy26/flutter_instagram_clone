import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';

class HomeController extends GetxController with HttpClient, SnackBar {

  final UserController userController;
  
  HomeController({
    required this.userController,
  });

  RxList<Rx<PostModel>> postsList = <Rx<PostModel>>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  PostModel currentPost (int index) => postsList[index].value;

  Future getPosts() async {

    try {
      hasError.value = false;
      isLoading.value = true;

      final result = await callApi(RequestTypes.get, "/post", null, userController.currentToken.toMap());
      postsList.value = (result!.data as List).map((e) => PostModel.fromMap(e).obs).toList();
      isLoading.value = false;

    } on DioError catch(e){
      errorSnackBar("Error on load posts");
      hasError.value = true;
      isLoading.value = false;
    } 

  }

  Future like(int index, int postId) async {
    try {
      final result = await callApi(RequestTypes.get, "/post-like/${postId}", null, userController.currentToken.toMap());
      postsList[index].update((val) {
        val!.isLiked = !val.isLiked;
      });
    } on DioError catch(e){
      errorSnackBar("Failed to perform action");
    }
  }

  Future updateLikeCount(int index, int postId) async {

    try {
      final result = await callApi(RequestTypes.get, "/post/${postId}", null, null);
      List<String> likesList = List<String>.from(result?.data[0]["likes"]);
      print(likesList);

      postsList[index].update((val) {
        val!.likes = likesList;
      });
    } on DioError catch(e){

    }
  }

  void goToComments(int index, int postId) async {
    List<Comment> commentsList = postsList[index].value.comments;
    Get.offAllNamed("/comments", arguments: { "postId": postId, "commentsList": commentsList });
  }

}
