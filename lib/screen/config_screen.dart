import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/configuration.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar("Configuración"),
      body: Container(
        color: UserSettings.instance.backgroundColor,
        child: const Configuration(),
      ),
    );
  }
}
