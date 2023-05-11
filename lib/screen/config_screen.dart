import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';

import '../widget/styled_app_bar.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StyledAppBar("Configuración"),
      body: Container(
        color: UserSettings.instance.backgroundColor,
        child: Container(),
      ),
    );
  }
}