import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:http_parser/http_parser.dart';

class PostController extends GetxController with HttpClient, SnackBar {

  final UserController userController;
  PostController({
    required this.userController,
  });

  RxBool isLoading = false.obs;

  Future post(String caption, File? image, void Function() onSucess) async {

    if(caption == ""){
      errorSnackBar("Type a caption");
      return;
    }

    if(image == null){
      errorSnackBar("Select a image");
      return;
    }

    isLoading.value = true;

    final formData = dio.FormData.fromMap({
      "caption": caption,
      "image": await dio.MultipartFile.fromFile(image.path, filename:DateTime.now().toIso8601String(), contentType: MediaType("image", "jpg")),
      "time": DateTime.now().toString()
    });

    try {
      final result = await callApi(RequestTypes.post, "/post", formData, userController.currentToken.toMap());
      sucessSnackBar("Post made");
      isLoading.value = false;
      onSucess();
    } on dio.DioError catch(e){
      isLoading.value = false;
      errorSnackBar("Failed to create post");
    }
  }

}
