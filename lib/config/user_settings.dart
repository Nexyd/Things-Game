import 'package:flutter/material.dart';

class UserSettings {
  String name;
  Image avatar;
  Color primaryColor;
  Color textColor;
  Color backgroundColor;
  String language;

  UserSettings({
    required this.name,
    required this.avatar,
    required this.primaryColor,
    required this.textColor,
    required this.backgroundColor,
    required this.language,
  });

  UserSettings._privateConstructor({
    required this.name,
    required this.avatar,
    required this.primaryColor,
    required this.textColor,
    required this.backgroundColor,
    required this.language,
  });

  static final UserSettings _instance = UserSettings._privateConstructor(
    name: "",
    avatar: Image.asset("null"),
    primaryColor: Colors.red,
    textColor: Colors.white,
    backgroundColor: Colors.grey.shade800,
    // backgroundColor: Colors.yellow,
    language: "en_ES",
  );

  static UserSettings get instance => _instance;
}
