import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/util/color_utils.dart';

import '../support/logger.dart';

class ThemeDataManager {
  static ThemeData build() {
    try {
      final primary = UserSettings.I.primaryColor;
      final textColor = UserSettings.I.textColor;
      return _buildTheme(primary, textColor);
    } catch (error) {
      Logger.settings.warning("[Theme] User settings not initialized", error);
      return _buildTheme(Colors.red, Colors.white);
    }
  }

  static ThemeData _buildTheme(Color primary, Color textColor) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: primary.shade(),
        secondary: primary,
        onSecondary: primary.shade(),
        error: primary,
        onError: primary,
        surface: primary,
        onSurface: primary,
      ),
      textTheme: TextTheme(
        bodySmall: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
      ),
    );
  }
}
