import 'package:flutter/material.dart';
import 'package:things_game/util/color_utils.dart';

class ThemeDataManager {
  static ThemeData build({
    required Color primary,
    required Color background,
    required Color text,
  }) {
    return ThemeData(
      primaryColor: primary,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: primary.shade(),
        secondary: background,
        onSecondary: background.shade(),
        error: primary,
        onError: primary,
        surface: primary,
        onSurface: primary,
      ),
      textTheme: TextTheme(
        bodySmall: TextStyle(color: text),
        bodyMedium: TextStyle(color: text),
        bodyLarge: TextStyle(color: text),
      ),
    );
  }
}
