// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AppColors {
  static Color primaryDark([double opacity = 1]) => Colors.black.withOpacity(opacity);
  static Color primaryLight([double opacity = 1]) => Colors.white.withOpacity(opacity);

  static Color secondaryDark([double opacity = 1]) => Color(0xFFAAAAAA).withOpacity(opacity);
}