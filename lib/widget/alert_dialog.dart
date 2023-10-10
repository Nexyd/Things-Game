import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/translations/alert_dialog.i18n.dart';

abstract class BasicDialog {
  final BuildContext context;
  final String? title;
  final String? content;
  final String buttonMessage;
  final Widget? icon;
  final Widget? contentWidget;
  final List<Widget>? actions;

  BasicDialog(
    this.context, {
    this.title,
    this.content,
    this.icon,
    this.contentWidget,
    required this.buttonMessage,
    this.actions,
  });

  void show() {
    assert(title != null || icon != null);
    assert(content != null || contentWidget != null);

    if (Platform.isAndroid) {
      _showAlertDialog();
    } else if (Platform.isIOS) {
      _showCupertinoDialog();
    }
  }

  void _showAlertDialog() {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: icon ?? StyledText(title!),
        backgroundColor: UserSettings.I.backgroundColor,
        content: contentWidget ?? StyledText(content!),
        actions: actions ??
            <Widget>[
              StyledButton(
                text: buttonMessage,
                type: ButtonType.text,
                onPressed: () => Navigator.pop(context),
              ),
            ],
      ),
    );
  }

  void _showCupertinoDialog() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: icon ??
            Text(
              title!,
              style: const TextStyle(color: Colors.black),
            ),
        content: contentWidget ??
            Text(
              content!,
              style: const TextStyle(color: Colors.black54),
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

class ErrorDialog extends BasicDialog {
  ErrorDialog(BuildContext context)
      : super(
          context,
          title: "Error".i18n,
          content: "An error has occurred".i18n,
          buttonMessage: "Accept".i18n,
        );
}

class ExitAppDialog extends BasicDialog {
  ExitAppDialog(BuildContext context)
      : super(
          context,
          title: "Exit app?".i18n,
          content: "",
          buttonMessage: "Accept".i18n,
          actions: _getActions(context),
        );

  static List<Widget> _getActions(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: StyledButton(
          text: "YES".i18n,
          type: ButtonType.text,
          onPressed: () => SystemNavigator.pop(),
        ),
      ),
      StyledButton(
        text: "NO".i18n,
        type: ButtonType.text,
        onPressed: () => Navigator.pop(context),
      ),
    ];
  }
}
