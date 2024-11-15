import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:provider/provider.dart';

import 'package:things_game/cubit/game_cubit.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/cubit/theme_switcher_cubit.dart';
import 'package:things_game/firebase_options.dart';
import 'package:things_game/screen/splash_screen.dart';
import 'package:things_game/support/logger.dart';
import 'package:things_game/support/route_generator.dart';
import 'package:things_game/widget/theme_switcher.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Logger.init(LoggerConfig(level: LoggerLevel.debug));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(I18n(child: const ThingsGame()));
}

class ThingsGame extends StatelessWidget {
  const ThingsGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // TODO: create room/game cubits when they are needed instead of here?
      BlocProvider(create: (context) => RoomCubit()),
      BlocProvider(create: (context) => GameCubit()),
      BlocProvider(create: (context) => ThemeSwitcherCubit()),
      Provider(create: (context) => OverlayPortalController()),
    ], child: const ThemeSwitcherWidget());
  }
}

class ThingsGameView extends StatelessWidget {
  final ThemeData themeData;

  const ThingsGameView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.routeGenerator,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: themeData,
      supportedLocales: const [Locale('en', "GB"), Locale('es', "ES")],
      home: const SplashScreen(),
    );
  }
}
