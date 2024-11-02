import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/util/debouncer.dart';

class StyledTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? type;
  final Function(String)? onChanged;
  final String? Function()? onError;
  final bool enabled;

  const StyledTextField({
    super.key,
    required this.hint,
    this.controller,
    this.type,
    this.onChanged,
    this.onError,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color
        ?? UserSettings.I.textColor;

    final debouncer = Debouncer(milliseconds: 500);
    final border = BorderSide(color: textColor);

    return TextField(
      controller: controller ?? TextEditingController(),
      keyboardType: type,
      enabled: enabled,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onChanged: (text) => debouncer.run(() => onChanged?.call(text)),
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: border),
        hintText: hint,
        errorText: onError?.call(),
        hintStyle: TextStyle(color: textColor),
      ),
    );
  }
}
