import 'package:flutter/material.dart';
import 'package:things_game/screen/user_settings_screen.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/config/user_settings.dart';

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
          "images/background_main.png",
        ),
        child: _getContent(context),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // Config button
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 35.0, top: 10.0),
            child: MaterialButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserSettingsScreen(),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: _getDecoration(
                  "images/config.png",
                ),
              ),
            ),
          ),
        ),

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
            onPressed: () => debugPrint("### create game clicked! ###"),
            text: "Crear partida",
          ),
        ),

        // Join game button
        StyledButton(
          onPressed: () => debugPrint("### join game clicked! ###"),
          text: "Unirse a partida",
          type: ButtonType.destructive,
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
