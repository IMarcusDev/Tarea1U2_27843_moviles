import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';


class FabStyles {
  static FloatingActionButtonThemeData get theme => FloatingActionButtonThemeData(
    backgroundColor: AppColors.accentPrimary,
    foregroundColor: AppColors.backgroundDark,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}