import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SnackBar {
  void sucessSnackBar(String message){
    Get.snackbar(
      "Sucess", 
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      backgroundColor: Colors.green
    );
  }

  void errorSnackBar(String message){
    Get.snackbar(
      "Error", 
      message,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      backgroundColor: Colors.red
    );
  }
}