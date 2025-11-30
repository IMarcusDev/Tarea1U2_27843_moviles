import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';


class DividerStyles {
  static DividerThemeData get theme => DividerThemeData(
    color: AppColors.textSecondary.withOpacity(0.2),
    thickness: 1,
    space: 20,
  );
}