import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/config_screen.i18n.dart';
import 'package:things_game/widget/game_settings.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';

class CreateRoomScreen extends StatelessWidget {
  final ConfigurationData data = ConfigurationData();

  CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = ValueNotifier<ConfigurationData>(data);
    return Scaffold(
      appBar: StyledAppBar("Game settings".i18n),
      body: Row(
        children: [
          Container(
            color: UserSettings.instance.backgroundColor,
            child: GameSettings(
              notifier: notifier,
            ),
          ),
          StyledButton(
            text: "text",
            onPressed: () {
              print("### create room pressed! ###");
            },
          ),
        ],
      ),
    );
  }
}
