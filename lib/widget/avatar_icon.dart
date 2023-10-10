import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    const double size = 30;
    String initial = "";

    if (UserSettings.I.name.isNotEmpty) {
      initial = UserSettings.I.name.substring(0, 1);
    }

    const textStyle = TextStyle(color: Colors.black, fontSize: 17);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(child: Text(initial, style: textStyle)),
    );
  }
}
