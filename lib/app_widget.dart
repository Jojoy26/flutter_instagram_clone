import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/bottomNavigation/bottom_navigation.dart';
import 'package:flutter_instagram/pages/comments/comments.dart';
import 'package:flutter_instagram/pages/login/login.dart';
import 'package:flutter_instagram/pages/profile/profile.dart';
import 'package:flutter_instagram/pages/signUp/sign_up.dart';
import 'package:flutter_instagram/pages/splash/splash.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType){
        return GetMaterialApp(
          home: SplashPage(),
          getPages: [
            GetPage(name: "/splash", page: () => SplashPage(),),
            GetPage(name: "/login", page: () => LoginPage(),),
            GetPage(name: "/signup", page: () => SignUpPage()),
            GetPage(name: "/bottomNavigation", page: () => BottomNavigation()),
            GetPage(name: "/comments", page: () => CommentsPage()),
            GetPage(name: "/profile", page: () => ProfilePage())
          ],
        );
      }
    );
  }
}