import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:things_game/constants.dart';
import 'package:things_game/widget/avatar_icon.dart';

class UserSettings {
  String name;
  Widget avatar;
  Color primaryColor;
  Color textColor;
  Color backgroundColor;
  Locale language;

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
    _instance = await _init();
  }

  static Future<UserSettings> _init() async {
    Map<String, String?> data = await _getSettingsFromPrefs();
    final primary = _getColor(data[PRIMARY_COLOR]);
    final text = _getColor(data[TEXT_COLOR]);
    final background = _getColor(data[BACKGROUND_COLOR]);
    final avatar = data[AVATAR] != null
        ? _getAvatarImage(data[AVATAR]!)
        : const AvatarIcon();

    return UserSettings._privateConstructor(
      name: data[NAME] ?? "Player",
      avatar: avatar,
      primaryColor: primary ?? Colors.red,
      textColor: text ?? Colors.white,
      backgroundColor: background ?? Colors.grey.shade800,
      language: _getLocale(data[LANGUAGE]),
    );
  }

  static Future<Map<String, String?>> _getSettingsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString(NAME),
      "avatar": prefs.getString(AVATAR),
      "primaryColor": prefs.getString(PRIMARY_COLOR),
      "textColor": prefs.getString(TEXT_COLOR),
      "backgroundColor": prefs.getString(BACKGROUND_COLOR),
      "language": prefs.getString(LANGUAGE),
    };
  }

  static Widget _getAvatarImage(String path) {
    final file = File(path);
    return SizedBox(
      width: AVATAR_SIZE,
      height: AVATAR_SIZE,
      child: Image.file(file),
    );
  }

  static Color? _getColor(String? hexString) {
    try {
      return Color(int.parse(hexString ?? "", radix: 16));
    } on Exception catch (_) {
      debugPrint("### Exception parsing hex color: $hexString ###");
      return null;
    }
  }

  static Locale _getLocale(String? locale) {
    final localeData = locale?.split("_");
    return localeData != null
        ? Locale(localeData[0], localeData[1])
        : const Locale("es", "ES");
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
