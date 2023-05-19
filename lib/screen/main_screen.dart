import 'dart:io';

import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/screen/user_settings_screen.dart';
import 'package:things_game/translations/main_screen.i18n.dart';
import 'package:things_game/widget/styled/styled_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserSettings.instance.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: _getDecoration(
          "assets/background_main.png",
        ),
        child: SafeArea(
          child: _getContent(context),
        ),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final configPadding = Platform.isIOS ? 25.0 : 10.0;

    return Column(
      children: [
        // Config button
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(right: 60.0, top: configPadding),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserSettingsScreen(),
                  ),
                ).then(
                  (value) {
                    setState(() {});
                  },
                );
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: _getDecoration(
                  "assets/config.png",
                ),
              ),
            ),
          ),
        ),

        // App Logo
        SizedBox(
          height: screenSize.height * 0.20,
          width: screenSize.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/logo.png",
              scale: 3,
            ),
          ),
        ),

        // Empty space
        SizedBox(
          height: screenSize.height * 0.30,
          width: screenSize.width,
        ),

        // Create game button
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: StyledButton(
            onPressed: () => debugPrint("### create game clicked! ###"),
            text: "Create game".i18n,
          ),
        ),

        // Join game button
        StyledButton(
          onPressed: () => debugPrint("### join game clicked! ###"),
          text: "Join game".i18n,
        ),
      ],
    );
  }

  BoxDecoration _getDecoration(String asset) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(asset),
        colorFilter: ColorFilter.mode(
          UserSettings.instance.primaryColor,
          BlendMode.srcIn,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}
