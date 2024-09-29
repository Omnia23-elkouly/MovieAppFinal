import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class MyThemeData {
  static const String rout = 'Home_screen';

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backDarkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 22, color: AppColors.primaryColor),
        bodyMedium: TextStyle(fontSize: 20, color: AppColors.primaryColor),
      ));
}
