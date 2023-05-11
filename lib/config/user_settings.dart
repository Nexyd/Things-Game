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

  static UserSettings? _instance;
  static UserSettings get instance {
    return _instance!;
  }

  static Future<void> init() async {
    Future.delayed(const Duration(seconds: 2));
    _instance = await _init();
  }

  static Future<UserSettings> _init() async {
    Map<String, String?> data = await _getSettingsFromPrefs();
    final primary = _getColor(data['primaryColor']);
    final text = _getColor(data['textColor']);
    final background = _getColor(data['backgroundColor']);

    return UserSettings._privateConstructor(
        name: data['name'] ?? "",
        avatar: data['name'] ?? "",
        primaryColor: primary ?? Colors.red,
        textColor: text ?? Colors.white,
        backgroundColor: background ?? Colors.grey.shade800,
        language: data['name'] ?? "es_ES",
      );
  }

  static Future<Map<String, String?>> _getSettingsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'avatar': prefs.getString('avatar'),
      'primaryColor': prefs.getString('primaryColor'),
      'textColor': prefs.getString('textColor'),
      'backgroundColor': prefs.getString('backgroundColor'),
      'language': prefs.getString('language'),
    };
  }

  static Color? _getColor(String? hexString) {
    try {
      return Color(int.parse(hexString ?? "", radix: 16));
    } on Exception catch (_) {
      debugPrint("### Exception parsing hex color: $hexString ###");
      return null;
    }
  }

  @override
  String toString() {
    final hexPrimary = primaryColor.value.toRadixString(16);
    final hexText = textColor.value.toRadixString(16);
    final hexBackground = backgroundColor.value.toRadixString(16);

    return "{"
      "name: $name,"
      "avatar: $avatar,"
      "primaryColor: #${hexPrimary.toUpperCase()},"
      "textColor: #${hexText.toUpperCase()},"
      "backgroundColor: #${hexBackground.toUpperCase()},"
      "language: $language"
    "}";
  }
}
