import 'package:flutter/material.dart';
import 'package:things_game/screen/main_screen.dart';

import '../config/user_settings.dart';

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
        // Navigate to main_screen
        print("### UserSettings initialized. ###");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add splash image.
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
