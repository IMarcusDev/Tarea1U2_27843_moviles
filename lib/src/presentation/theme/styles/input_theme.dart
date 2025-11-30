import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';


class InputStyles {
  static InputDecorationTheme get theme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColors.accentPrimary.withOpacity(0.2),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColors.accentPrimary.withOpacity(0.15),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.accentPrimary,
        width: 2,
      ),
    ),
    hintStyle: const TextStyle(color: AppColors.textSecondary),
    prefixIconColor: AppColors.accentPrimary,
    suffixIconColor: AppColors.textSecondary,
  );
}