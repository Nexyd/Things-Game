import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/constants.dart';
import 'package:things_game/widget/styled/styled_text.dart';

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
    );
  }

  void raiseDialog(BuildContext context) {
    Color pickerColor = _getColorFromSettings();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StyledText('Pick a color!'),
          backgroundColor: UserSettings.instance.backgroundColor,
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              labelTextStyle: TextStyle(
                color: UserSettings.instance.textColor,
              ),
              onColorChanged: (color) {
                setState(() => pickerColor = color);
              },
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                bottom: 10.0,
              ),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: const StyledText(
                  'Cancel',
                  isDestructive: true,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                bottom: 10.0,
              ),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: const StyledText(
                  'Got it',
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  _saveToPrefs(pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ),
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
      case PRIMARY_COLOR:
        UserSettings.instance.primaryColor = color;
        break;

      case TEXT_COLOR:
        UserSettings.instance.textColor = color;
        break;

      case BACKGROUND_COLOR:
        UserSettings.instance.backgroundColor = color;
        break;
    }
  }

  Color _getColorFromSettings() {
    switch (widget.colorTag) {
      case PRIMARY_COLOR:
        return UserSettings.instance.primaryColor;

      case TEXT_COLOR:
        return UserSettings.instance.textColor;

      case BACKGROUND_COLOR:
        return UserSettings.instance.backgroundColor;

      default:
        return Colors.red;
    }
  }
}
