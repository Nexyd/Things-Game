import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/game_settings_screen.i18n.dart';
import 'package:things_game/widget/game_settings.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';

class GameSettingsScreen extends StatelessWidget {
  final ConfigurationData data = ConfigurationData();

  GameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = ValueNotifier<ConfigurationData>(data);
    // FIXME: not appearing on fullscreen.
    return Scaffold(
      appBar: StyledAppBar("Game settings".i18n),
      body: Container(
        color: UserSettings.I.backgroundColor,
        child: GameSettings(
          notifier: notifier,
        ),
      ),
    );
  }
}
