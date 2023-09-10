import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:things_game/route_generator.dart';
import 'package:things_game/screen/splash_screen.dart';

import 'cubit/game_settings_cubit.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );

  runApp(
    I18n(child: const ThingsGame()),
  );
}

class ThingsGame extends StatelessWidget {
  const ThingsGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GameSettingsCubit(),
        ),
        BlocProvider(
          create: (context) => GameSettingsCubit(),
        ),
      ],
      child: const ThingsGameView(),
    );
  }
}

class ThingsGameView extends StatelessWidget {
  const ThingsGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: RouteGenerator.routeGenerator,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', "GB"),
        Locale('es', "ES"),
      ],
      home: SplashScreen(),
    );
  }
}
