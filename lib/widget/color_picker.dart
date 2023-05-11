import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
    required this.colorTag,
  });

  final String colorTag;

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<CustomColorPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => raiseDialog(context),
      child: Container(
        color: Colors.red.shade300,
        width: 100,
        height: 50,
      ),
    );
  }

  void raiseDialog(BuildContext context) {
    Color pickerColor = _getColorFromSettings();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                setState(() => pickerColor = color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                _saveToPrefs(pickerColor);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _saveToPrefs(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    final hexString = color.value.toRadixString(16);
    print("### hex: #$hexString ###");
    prefs.setString(widget.colorTag, hexString);

    switch (widget.colorTag) {
      case "primaryColor":
        UserSettings.instance.primaryColor = color;
        break;

      case "textColor":
        UserSettings.instance.textColor = color;
        break;

      case "backgroundColor":
        UserSettings.instance.backgroundColor = color;
        break;
    }
  }

  Color _getColorFromSettings() {
    switch (widget.colorTag) {
      case "primaryColor":
        return UserSettings.instance.primaryColor;

      case "textColor":
        return UserSettings.instance.textColor;

      case "backgroundColor":
        return UserSettings.instance.backgroundColor;

      default:
        return Colors.red;
    }
  }
}