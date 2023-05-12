import 'package:flutter/cupertino.dart';
import 'package:things_game/config/user_settings.dart';

class StyledText extends StatelessWidget {
  final String text;
  final bool isDestructive;
  final FontWeight? fontWeight;

  const StyledText(
    this.text, {
    super.key,
    this.isDestructive = false,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = UserSettings.instance.textColor;
    if (isDestructive) {
      textColor = UserSettings.instance.primaryColor;
    }

    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
