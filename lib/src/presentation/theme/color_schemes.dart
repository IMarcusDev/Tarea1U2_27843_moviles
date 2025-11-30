import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';


class AppColorSchemes {
  static const ColorScheme darkScheme = ColorScheme.dark(
    primary: AppColors.accentPrimary,
    secondary: AppColors.accentGold,
    tertiary: AppColors.accentGreen,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
  );
}