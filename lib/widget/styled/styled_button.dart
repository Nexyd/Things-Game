import 'dart:io';

import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/config/user_settings.dart';

enum ButtonType { constructive, destructive, text }

class StyledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final ButtonType? type;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.constructive,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.constructive) {
      return _getConstructiveButton();
    } else if (type == ButtonType.destructive) {
      return _getDestructiveButton();
    }

    return _getTextButton();
  }

  Widget _getConstructiveButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 140),
      child: MaterialButton(
        onPressed: onPressed,
        color: UserSettings.I.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: StyledText(text),
      ),
    );
  }

  Widget _getDestructiveButton() {
    return SizedBox(
      width: 140,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 2.0,
            color: UserSettings.I.primaryColor,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: StyledText(text, isDestructive: true),
      ),
    );
  }

  Widget _getTextButton() {
    if (Platform.isIOS) {
      return TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: UserSettings.I.primaryColor,
            fontSize: 18,
          ),
        ),
        onPressed: onPressed,
        child: StyledText(text, isDestructive: true),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: onPressed,
        splashFactory: NoSplash.splashFactory,
        child: StyledText(
          text,
          isDestructive: true,
          fontSize: 18,
        ),
      ),
    );
  }
}
