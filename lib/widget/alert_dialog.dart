import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';

class BasicDialog {
  final String? title;
  final String? content;
  final String buttonMessage;
  final Widget? icon;
  final Widget? contentWidget;

  BasicDialog({
    this.title,
    this.content,
    this.icon,
    this.contentWidget,
    required this.buttonMessage,
  });

  void show(BuildContext context) {
    assert(title != null || icon != null);
    assert(content != null || contentWidget != null);

    if (Platform.isAndroid) {
      _showAlertDialog(context);
    } else if (Platform.isIOS) {
      _showCupertinoDialog(context);
    }
  }

  void _showAlertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: icon ?? StyledText(title!),
        backgroundColor: UserSettings.I.backgroundColor,
        content: contentWidget ?? StyledText(content!),
        actions: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: StyledButton(
              text: buttonMessage,
              type: ButtonType.text,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showCupertinoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: icon ?? Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        content: contentWidget ?? Text(
          content!,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        actions: <Widget>[
          Center(
            child: StyledButton(
              text: buttonMessage,
              type: ButtonType.text,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
