import 'package:flutter/material.dart';
import 'package:things_game/screen/create_room_screen.dart';
import 'package:things_game/screen/room_settings_screen.dart';
import 'package:things_game/screen/lobby_screen.dart';
import 'package:things_game/screen/main_screen.dart';
import 'package:things_game/screen/search_room_screen.dart';
import 'package:things_game/screen/splash_screen.dart';
import 'package:things_game/screen/user_settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case "/main":
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: settings,
        );

      case "/create":
        return MaterialPageRoute(
          builder: (_) => CreateRoomScreen(),
          settings: settings,
        );

      case "/search":
        return MaterialPageRoute(
          builder: (_) => const SearchRoomScreen(),
          settings: settings,
        );

      case "/lobby":
        return MaterialPageRoute(
          builder: (_) => LobbyScreen(args as LobbyScreenArguments),
          settings: settings,
        );

      case "/preferences":
        return MaterialPageRoute(
          builder: (_) => const UserSettingsScreen(),
          settings: settings,
        );

      case "/roomSettings":
        return MaterialPageRoute(
          builder: (_) => RoomSettingsScreen(
            args as RoomSettingsScreenArgs,
          ),
          settings: settings,
        );
    }

    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      // TODO: Create error page?
      builder: (_) => const MainScreen(),
    );
  }
}
