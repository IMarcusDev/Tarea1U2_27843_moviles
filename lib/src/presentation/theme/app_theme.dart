import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de colores inspirada en la tecnología Sheikah / Zelda
  static const Color primaryDark = Color(0xFF0F172A); // Fondo muy oscuro
  static const Color primaryLight = Color(0xFF1E293B); // Fondo de tarjetas
  static const Color accentGold = Color(0xFFD4AF37); // Dorado legendario
  static const Color accentBlue = Color(0xFF00D2FF); // Azul neón Sheikah

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,

      // Esquema de colores principal
      colorScheme: const ColorScheme.dark(
        primary: accentBlue,
        secondary: accentGold,
        surface: primaryLight,
        onSurface: Colors.white,
      ),

      // Estilo del AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: accentGold),
        titleTextStyle: TextStyle(
          fontFamily: 'Serif', // Si tienes una fuente custom, ponla aquí
          color: accentGold,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),

      // Estilo de las tarjetas (Items)
      cardTheme: CardThemeData(
        color: primaryLight,
        elevation: 8,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: accentBlue.withAlpha(77), width: 1),
        ),
      ),
    );
  }
}
