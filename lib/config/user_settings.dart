import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static late final UserSettings? _instance;

  String name;
  Image avatar;
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

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final primary = _getColor(prefs.getString('primaryColor'));
    final text = _getColor(prefs.getString('textColor'));
    final background = _getColor(prefs.getString('backgroundColor'));

    _instance = UserSettings._privateConstructor(
      name: prefs.getString('name') ?? "",
      avatar: Image.asset(prefs.getString('avatar') ?? "null"),
      primaryColor: primary ?? Colors.red,
      textColor: text ?? Colors.white,
      backgroundColor: background ?? Colors.grey.shade800,
      language: prefs.getString('language') ?? "es_ES",
    );
  }

  static Color? _getColor(String? hexString) {
    try {
      return Color(int.parse(hexString!, radix: 16));
    } on Exception catch (error) {
      debugPrint("### Exception parsing hex color: $error ###");
      return null;
    }
  }

  static UserSettings get instance {
    if (_instance == null) {
      UserSettings.init();
    }

    return _instance!;
  }
}
