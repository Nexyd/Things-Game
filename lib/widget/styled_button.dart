import 'package:flutter/material.dart';

import '../config/user_settings.dart';

enum ButtonType { constructive, destructive }

class StyledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final ButtonType? type;

  const StyledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = ButtonType.constructive,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.constructive) {
      return _getConstructiveButton();
    } else {
      return _getDestructiveButton();
    }
  }

  Widget _getConstructiveButton() {
    return SizedBox(
      width: 135,
      child: MaterialButton(
        onPressed: onPressed,
        color: UserSettings.instance.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: UserSettings.instance.textColor,
          ),
        ),
      ),
    );
  }

  Widget _getDestructiveButton() {
    return SizedBox(
      width: 135,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 2.0,
            color: UserSettings.instance.primaryColor,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: UserSettings.instance.primaryColor,
          ),
        ),
      ),
    );
  }
}
