import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/splash_controller.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final controller = Modular.get<SplashController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.verifyToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark(),
      body: Container(
        child: Center(
          child: Hero(
            tag: "logo",
            child: SvgPicture.asset("lib/assets/images/ic_instagram.svg", color: AppColors.primaryLight(),),
          ),
        ),
      ),
    );
  }
}