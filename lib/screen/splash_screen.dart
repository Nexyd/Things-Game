import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:i18n_extension/i18n_widget.dart';

import 'package:things_game/config/user_settings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    UserSettings.init().then((value) {
      setState(() {
        FlutterNativeSplash.remove();
        print("### UserSettings initialized ###");

        I18n.of(context).locale = UserSettings.I.language;
        print("### Language: ${UserSettings.I.language} ###");

        Navigator.of(context).pushNamed("/main");
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFff7171),
      ),
    );
  }
}
