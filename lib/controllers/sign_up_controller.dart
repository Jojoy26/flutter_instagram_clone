import 'dart:io';

import 'package:dio/dio.dart' as dio;

import 'package:flutter_instagram/httpClient/mixin_http_client.dart';
import 'package:flutter_instagram/utils/snackBar/snack_bar.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

class SignUpController extends GetxController with HttpClient, SnackBar {

  String username = "";
  String email = "";
  String password = "";
  String bio = "";
  late File profileImage;

  void goToLogin(){
    Get.offAllNamed("/login");
  }

  Future signUp() async{

    dio.FormData formData = dio.FormData.fromMap({
      "username": username,
      "email": email,
      "password": password,
      "bio": bio,
      "profile": await dio.MultipartFile.fromFile(profileImage.path, filename:DateTime.now().toIso8601String(), contentType: MediaType("image", "jpg")),
      "fullname": ""
    });

    try {
      final result = await callApi(RequestTypes.post, "/signup", formData, null);
      sucessSnackBar("Account created sucessfully");
      Get.toNamed("/login");
    } on dio.DioError catch(e){
      if(e.response == null){
        errorSnackBar("Failed on create account verify your internet connection"); 
      }
      String error = e.response!.data["detail"];
      error.contains("username");
      if(error.contains("username")){
        errorSnackBar("Username already in use");
        return;
      } else if(error.contains("email")) {
        errorSnackBar("Email already in use");
        return;
      }
      
      
    }
    
  
  }

}