import 'package:dio/dio.dart';
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/user_controller.dart';

class CommentController extends GetxController with SnackBar, HttpClient {

  final UserController userController;
  CommentController({
    required this.userController,
  });

  RxList<Comment> commentsList = <Comment>[].obs;

  Future comment(String text, int postId) async {

    if(text == ""){
      errorSnackBar("Enter an comment");
      return;
    }
    try {
      final result = await callApi(RequestTypes.post, "/post-comment/${postId}", {
        "comment": text,
        "time": DateTime.now().toString()
      }, userController.currentToken.toMap());
      updateComments(postId);
    } on DioError catch(e){
      errorSnackBar("Failed to comment");
    }
  }

  Future updateComments(int postId) async {
    try {
      final result = await callApi(RequestTypes.get, "/post/${postId}", null, userController.currentToken.toMap());
      final post = PostModel.fromMap(result!.data[0]);
      commentsList.value = post.comments;
    } on DioError catch(e){
      errorSnackBar("Failed to load new comments");
    }
  }

}
