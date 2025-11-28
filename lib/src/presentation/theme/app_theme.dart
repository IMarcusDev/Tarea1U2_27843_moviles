import 'package:flutter/material.dart';

class AppTheme {
  // Seed color for the app. You can change this to tune the palette.
  static const Color seed = Color(0xFF6A1B9A); // deep purple

  static ThemeData get themeData {
    final colorScheme = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);

    // Keep a safe, SDK-compatible ThemeData while still using a seeded ColorScheme
    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: Typography.material2021().black,
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        centerTitle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),
    );
  }
}
