import 'package:flutter/material.dart';
import 'package:things_game/widget/color_picker.dart';

import '../widget/styled_button.dart';
import '../config/user_settings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserSettings.instance.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              "images/background_main.png",
            ),
            colorFilter: ColorFilter.mode(
              UserSettings.instance.primaryColor,
              BlendMode.srcIn,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: _getContent(context),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // App Logo
        SizedBox(
          height: screenSize.height * 0.65,
          width: screenSize.width,
          child: Image.asset(
            "images/logo.png",
            scale: 3,
          ),
        ),

        // Create game button
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: StyledButton(
            onPressed: () => print("### create game clicked! ###"),
            text: "Crear partida",
          ),
        ),

        // Join game button
        // StyledButton(
        //   onPressed: () => print("### join game clicked! ###"),
        //   text: "Unirse a partida",
        //   type: ButtonType.destructive,
        // ),
        const CustomColorPicker(
          colorTag: "primaryColor",
        ),
      ],
    );
  }
}
