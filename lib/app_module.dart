import 'package:flutter_instagram/controllers/comment_controller.dart';
import 'package:flutter_instagram/controllers/home_controller.dart';
import 'package:flutter_instagram/controllers/login_controller.dart';
import 'package:flutter_instagram/controllers/post_controller.dart';
import 'package:flutter_instagram/controllers/profile_controller.dart';
import 'package:flutter_instagram/controllers/search_controller.dart';
import 'package:flutter_instagram/controllers/secure_storage_controller.dart';
import 'package:flutter_instagram/controllers/splash_controller.dart';
import 'package:flutter_instagram/controllers/user_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory<FlutterSecureStorage>((i) => FlutterSecureStorage()),

    Bind.factory<SecureStorageController>((i) => SecureStorageController(storage: i())),

    Bind.singleton<UserController>((i) => UserController()),
    Bind.factory<LoginController>((i) => LoginController(storageController: i(), userController: i())),
    Bind.singleton<HomeController>((i) => HomeController(userController: i())),
    Bind.factory<CommentController>((i) => CommentController(userController: i())),
    Bind.factory<SearchController>((i) => SearchController(userController: i())),
    Bind.factory<ProfileController>((i) => ProfileController(userController: i(), storageController: i())),
    Bind.factory<SplashController>((i) => SplashController(storageController: i(), userController: i())),
    Bind.factory<PostController>((i) => PostController(userController: i()))
  ];
}