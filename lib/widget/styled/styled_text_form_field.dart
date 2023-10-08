import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/util/debouncer.dart';

class StyledTextForm extends StatelessWidget {
  final String hint;
  final String? initialValue;
  final TextInputType? type;
  final Function(String)? onChanged;
  final String? Function(String)? validator;
  final bool enabled;

  const StyledTextForm({
    super.key,
    required this.hint,
    this.initialValue,
    this.type,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 500);
    final border = BorderSide(color: UserSettings.I.textColor);

    return TextFormField(
      initialValue: initialValue,
      keyboardType: type,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onChanged: (text) => debouncer.run(() => onChanged?.call(text)),
      validator: (text) => validator?.call(text ?? ""),
      style: TextStyle(color: UserSettings.I.textColor),
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: border),
        hintText: hint,
        hintStyle: TextStyle(color: UserSettings.I.textColor),
      ),
    );
  }
}