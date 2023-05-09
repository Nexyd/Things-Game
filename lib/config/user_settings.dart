import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  String name;
  String avatar;
  Color primaryColor;
  Color textColor;
  Color backgroundColor;
  String language;

  UserSettings._privateConstructor({
    required this.name,
    required this.avatar,
    required this.primaryColor,
    required this.textColor,
    required this.backgroundColor,
    required this.language,
  });

  static final UserSettings _instance = _init();

  static UserSettings get instance => _instance;

  static UserSettings _init() {
    Map<String, String?> data = {};
    _getSettingsFromPrefs().then(
      (value) => data.addAll(value),
    );

    final primary = _getColor(data['primaryColor'] ?? "");
    final text = _getColor(data['textColor'] ?? "");
    final background = _getColor(data['backgroundColor'] ?? "");

    return UserSettings._privateConstructor(
      name: data['name'] ?? "",
      avatar: data['avatar'] ?? "",
      primaryColor: primary ?? Colors.red,
      textColor: text ?? Colors.white,
      backgroundColor: background ?? Colors.grey.shade800,
      language: data['language'] ?? "es_ES",
    );
  }

  static Future<Map<String, String?>> _getSettingsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'avatar': prefs.getString('avatar'),
      'primary': prefs.getString('primary'),
      'primaryColor': prefs.getString('primaryColor'),
      'textColor': prefs.getString('textColor'),
      'backgroundColor': prefs.getString('backgroundColor'),
      'language': prefs.getString('language'),
    };
  }

  static Color? _getColor(String hexString) {
    try {
      return Color(int.parse(hexString, radix: 16));
    } on Exception catch (error) {
      debugPrint(
          "### Exception parsing hex color: $hexString - Error: $error ###");
      return null;
    }
  }
}
