import 'package:flutter/cupertino.dart';
import 'package:things_game/config/user_settings.dart';

class StyledText extends StatelessWidget {
  final String text;
  final bool isDestructive;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;

  const StyledText(
    this.text, {
    super.key,
    this.isDestructive = false,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
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
        fontSize: fontSize,
        fontStyle: fontStyle,
      ),
    );
  }
}
