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

  //static final UserSettings _instance = _init();
  static final Future<UserSettings> _instance = _init();

  //static UserSettings get instance => _instance;
  static Future<UserSettings> get instance async {
    return await _instance;
  }

  static Future<UserSettings> _init() async {
    // _getSettingsFromPrefs().then(
    //   (value) => _setFromPrefs(value),
    // );
    Map<String, String?> data = await _getSettingsFromPrefs();
    final primary = _getColor(data['primaryColor']);
    final text = _getColor(data['textColor']);
    final background = _getColor(data['backgroundColor']);

    return await Future.value(
        UserSettings._privateConstructor(
        name: data['name'] ?? "",
        avatar: data['name'] ?? "",
        primaryColor: primary ?? Colors.red,
        textColor: text ?? Colors.white,
        backgroundColor: background ?? Colors.grey.shade800,
        language: data['name'] ?? "es_ES",
      )
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

  // static void _setFromPrefs(Map<String, String?> prefs) {
  //   final primary = _getColor(prefs['primaryColor']);
  //   final text = _getColor(prefs['textColor']);
  //   final background = _getColor(prefs['backgroundColor']);
  //
  //   instance.name = prefs['name'] ?? "";
  //   instance.avatar = prefs['avatar'] ?? "";
  //   instance.primaryColor = primary ?? Colors.red;
  //   instance.textColor = text ?? Colors.white;
  //   instance.backgroundColor = background ?? Colors.grey.shade800;
  //   instance.language = prefs['language'] ?? "es_ES";
  //
  //   debugPrint("### UserSettings: ${instance.toString()} ###");
  // }

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
