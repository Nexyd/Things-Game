import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';

import '../config/user_settings.dart';

class PlayerWidget extends StatelessWidget {
  final String name;
  final Widget icon;

  const PlayerWidget({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserSettings.I.avatar,
      title: StyledText(name),
      trailing: icon,
    );
  }
}
