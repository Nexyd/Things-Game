import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/util/debouncer.dart';

class StyledTextField extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const StyledTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.controller,
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
        color: UserSettings.instance.textColor,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: UserSettings.instance.textColor,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: UserSettings.instance.textColor,
        ),
      ),
    );
  }
}
