import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/game_settings_screen.i18n.dart';
import 'package:things_game/widget/game_settings.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class GameSettingsScreenArgs {
  final GlobalKey? key;
  final ConfigurationData data;

  GameSettingsScreenArgs({
    this.key,
    required this.data,
  });
}

class GameSettingsScreen extends StatelessWidget {
  final GameSettingsScreenArgs args;

  const GameSettingsScreen(
    this.args, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = ValueNotifier<ConfigurationData>(args.data);
    return Scaffold(
      appBar: StyledAppBar("Game settings".i18n),
      backgroundColor: UserSettings.I.backgroundColor,
      body: Column(
        children: [
          GameSettings(
            notifier: notifier,
            key: args.key,
            isPlayersFieldEnabled: false,
          ),
        ],
      ),
    );
  }
}
