import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/models/user_token.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  UserToken currentToken = UserToken(token: "token");
  late UserModel currentUserModel;

  void setToken(String token){
    currentToken = UserToken(token: token);
  }
  void setUser(UserModel model){
    currentUserModel = model;
  }
}