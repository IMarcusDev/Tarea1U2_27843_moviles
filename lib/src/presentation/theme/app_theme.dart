import 'package:flutter/material.dart';
import 'package:tarea_api_app/src/presentation/theme/app_colors.dart';
import 'package:tarea_api_app/src/presentation/theme/color_schemes.dart';
import 'package:tarea_api_app/src/presentation/theme/styles/appbar_theme.dart';
import 'package:tarea_api_app/src/presentation/theme/styles/card_theme.dart';
import 'package:tarea_api_app/src/presentation/theme/styles/divider_theme.dart';
import 'package:tarea_api_app/src/presentation/theme/styles/fab_theme.dart';
import 'package:tarea_api_app/src/presentation/theme/styles/icon_theme.dart';
import 'package:tarea_api_app/src/presentation/theme/styles/input_theme.dart';


class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: AppColorSchemes.darkScheme,
      appBarTheme: AppBarStyles.theme,
      cardTheme: CardStyles.theme,
      floatingActionButtonTheme: FabStyles.theme,
      inputDecorationTheme: InputStyles.theme,
      dividerTheme: DividerStyles.theme,
      iconTheme: IconStyles.theme,
    );
  }
}
