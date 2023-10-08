import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/room_settings_screen.i18n.dart';
import 'package:things_game/widget/room_settings.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class RoomSettingsScreenArgs {
  final ConfigurationData data;

  RoomSettingsScreenArgs({required this.data});
}

class RoomSettingsScreen extends StatelessWidget {
  final RoomSettingsScreenArgs args;

  const RoomSettingsScreen(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar("Game settings".i18n),
      backgroundColor: UserSettings.I.backgroundColor,
      body: RoomSettings(
        config: args.data,
        isPlayersFieldEnabled: false,
      ),
    );
  }
}
