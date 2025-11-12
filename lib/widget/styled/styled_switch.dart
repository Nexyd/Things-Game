import 'package:flutter/material.dart';
import 'package:things_game/util/color_utils.dart';

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
  bool? _active;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null && _active == null) {
      _active = widget.value!;
    }

    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Switch(
      value: _active!,
      activeThumbColor: Theme.of(context).primaryColor,
      inactiveThumbColor: surfaceColor.shade(90),
      inactiveTrackColor: surfaceColor,
      onChanged: (value) {
        widget.onChanged.call(value);
        setState(() => _active = value);
      },
    );
  }
}
