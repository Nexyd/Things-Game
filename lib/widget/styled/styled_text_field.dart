import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/util/debouncer.dart';

class StyledTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? type;
  final Function(String)? onChanged;
  final String? Function()? onError;

  const StyledTextField({
    super.key,
    required this.hint,
    this.controller,
    this.type,
    this.onChanged,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 500);
    return TextField(
      controller: controller ?? TextEditingController(),
      keyboardType: type,
      onChanged: (text) {
        debouncer.run(() {
          if (onChanged != null) {
            onChanged!(text);
          }
        });
      },
      style: TextStyle(
        color: UserSettings.I.textColor,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: UserSettings.I.textColor,
          ),
        ),
        hintText: hint,
        errorText: _getErrorText(),
        hintStyle: TextStyle(
          color: UserSettings.I.textColor,
        ),
      ),
    );
  }

  String? _getErrorText() {
    if (onError != null) {
      return onError!();
    }

    return null;
  }
}
