import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/app_module.dart';
import 'package:flutter_instagram/app_widget.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primaryDark()
    )
  );
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

