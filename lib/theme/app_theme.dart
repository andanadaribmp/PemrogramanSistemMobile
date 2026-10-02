import 'package:flutter/material.dart';

abstract final class TokoColors {
  static const primary = Color(0xFF00A83B);
  static const primaryDark = Color(0xFF008F39);
  static const paleGreen = Color(0xFFE8F8EE);
  static const background = Color(0xFFF5F5F5);
  static const ink = Color(0xFF303030);
  static const muted = Color(0xFF808080);
  static const border = Color(0xFFEAEAEA);
  static const success = Color(0xFF00A83B);
}

abstract final class TokoTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: TokoColors.primary,
      brightness: Brightness.light,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: colorScheme.copyWith(
        primary: TokoColors.primary,
        secondary: TokoColors.primaryDark,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: TokoColors.background,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: TokoColors.ink,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: TokoColors.ink,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: TokoColors.ink,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(color: TokoColors.ink, fontSize: 14),
        bodySmall: TextStyle(color: TokoColors.muted, fontSize: 12),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: TokoColors.paleGreen,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? TokoColors.primary
                : TokoColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          );
        }),
      ),
    );
  }
}
