import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:things_game/screen/splash_screen.dart';

void main() {
  runApp(
    I18n(child: const ThingsGame()),
  );
}

class ThingsGame extends StatelessWidget {
  const ThingsGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', "ES"),
        Locale('en', "GB"),
      ],
      home: SplashScreen(),
    );
  }
}
