import 'package:flutter/material.dart';
import 'package:things_game/config/user_settings.dart';

class StyledSwitch extends StatefulWidget {
  final bool? value;
  final Function(bool) onChanged;

  const StyledSwitch({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  State<StyledSwitch> createState() => _StyledTextState();
}

class _StyledTextState extends State<StyledSwitch> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      light = widget.value!;
    }

    return Switch(
      value: light,
      activeColor: UserSettings.I.primaryColor,
      onChanged: (value) {
        widget.onChanged.call(value);
        setState(() => light = value);
      },
    );
  }
}
