import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';


class AppBarStyles {
  static const AppBarTheme theme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: AppColors.accentGold,
      size: 22,
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontSize: 22,
      letterSpacing: 0.5,
    ),
  );
}