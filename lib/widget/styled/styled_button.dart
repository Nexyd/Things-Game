import 'dart:io';

import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';

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
      return _getConstructiveButton(context);
    } else if (type == ButtonType.destructive) {
      return _getDestructiveButton(context);
    }

    return _getTextButton(context);
  }

  Widget _getConstructiveButton(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160),
      child: MaterialButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: StyledText(text),
      ),
    );
  }

  Widget _getDestructiveButton(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 2.0,
            color: Theme.of(context).primaryColor,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: StyledText(text, isDestructive: true),
      ),
    );
  }

  Widget _getTextButton(BuildContext context) {
    if (Platform.isIOS) {
      final color = Theme.of(context).primaryColor;
      return TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: color, fontSize: 18),
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
        child: StyledText(text, isDestructive: true, fontSize: 18),
      ),
    );
  }
}
