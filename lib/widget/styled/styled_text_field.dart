import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/util/debouncer.dart';

class StyledTextField extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function()? onError;

  const StyledTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.controller,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 500);
    return TextField(
      controller: controller ?? TextEditingController(),
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
        // TODO: this gets called only once.
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
