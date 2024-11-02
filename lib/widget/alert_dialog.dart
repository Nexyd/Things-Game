import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final list = <Widget>[
      StyledButton(
        text: buttonMessage,
        type: ButtonType.text,
        onPressed: () => Navigator.pop(context),
      ),
    ];

    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: icon ?? StyledText(title!),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: contentWidget ?? StyledText(content!),
        actions: actions ?? list,
      ),
    );
  }

  void _showCupertinoDialog() {
    const styleBlack = TextStyle(color: Colors.black);
    const styleBlack54 = TextStyle(color: Colors.black54);

    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: icon ?? Text(title!, style: styleBlack),
        content: contentWidget ?? Text(content!, style: styleBlack54),
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
  ErrorDialog(super.context)
      : super(
          title: "Error".i18n,
          content: "An error has occurred".i18n,
          buttonMessage: "Accept".i18n,
        );
}

class ExitAppDialog extends BasicDialog {
  ExitAppDialog(super.context)
      : super(
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
