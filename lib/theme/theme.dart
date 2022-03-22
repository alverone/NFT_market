import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  fontFamily: 'Manrope',
  splashFactory: InkRipple.splashFactory,
  highlightColor: AppColors.main.withOpacity(0.1),
  splashColor: AppColors.main.withOpacity(0.1),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      height: 38 / 28,
      color: AppColors.black,
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      height: 33 / 24,
      color: AppColors.black,
      fontWeight: FontWeight.w800,
    ),
    headlineSmall: TextStyle(
      fontSize: 22,
      height: 30 / 22,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      height: 25 / 18,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.darkGrey,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      height: 19 / 14,
      fontWeight: FontWeight.w600,
      //color: AppColors.black,
    ),
  ),
);
