import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';

class CardStyles {
  static CardThemeData get theme => CardThemeData(
    color: AppColors.surfaceLight,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: AppColors.accentPrimary.withOpacity(0.1),
        width: 1,
      ),
    ),
  );
}