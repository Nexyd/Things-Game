import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/config_screen.i18n.dart';
import 'package:things_game/widget/configuration.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';

class ConfigScreen extends StatelessWidget {
  final ConfigurationData data = ConfigurationData();

  ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = ValueNotifier<ConfigurationData>(data);
    return Scaffold(
      appBar: StyledAppBar("Create a room".i18n),
      body: Container(
        color: UserSettings.instance.backgroundColor,
        // child: Row(
        //   children: [
            child: Configuration(
              notifier: notifier,
            ),
          //   StyledButton(
          //     onPressed: () {
          //       print("### create room pressed! ###");
          //     },
          //     text: "Create".i18n,
          //   ),
          // ],
        //),
      ),
    );
  }
}
