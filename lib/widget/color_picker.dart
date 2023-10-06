import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/constants.dart';
import 'package:things_game/widget/styled/styled_text.dart';

class ColorPickerWrapper extends StatefulWidget {
  final String colorTag;
  final Function() callback;

  const ColorPickerWrapper({
    super.key,
    required this.colorTag,
    required this.callback,
  });

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

enum _DialogButtonType { left, right }

class _ColorPickerState extends State<ColorPickerWrapper> {
  Color? pickerColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => raiseDialog(context),
    );
  }

  void raiseDialog(BuildContext context) {
    pickerColor = _getColorFromSettings();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StyledText('Pick a color!'),
          backgroundColor: UserSettings.I.backgroundColor,
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor!,
              labelTextStyle: TextStyle(
                color: UserSettings.I.textColor,
              ),
              onColorChanged: (color) {
                setState(() => pickerColor = color);
              },
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            _getButton(_DialogButtonType.left),
            _getButton(_DialogButtonType.right),
          ],
        );
      },
    ).whenComplete(
      () => widget.callback(),
    );
  }

  Widget _getButton(_DialogButtonType type) {
    bool isLeft = type == _DialogButtonType.left;
    String title = isLeft ? "Cancel" : "Got it";

    return Padding(
      padding: EdgeInsets.only(
        left: isLeft ? 10.0 : 0.0,
        right: isLeft ? 0.0 : 10.0,
        bottom: 10.0,
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          if (!isLeft && pickerColor != null) {
            _saveToPrefs(pickerColor!);
          }

          Navigator.of(context).pop();
        },
        child: StyledText(
          title,
          isDestructive: isLeft,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _saveToPrefs(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    final hexString = color.value.toRadixString(16);
    prefs.setString(widget.colorTag, hexString);

    switch (widget.colorTag) {
      case PRIMARY_COLOR:
        UserSettings.I.primaryColor = color;
        break;

      case TEXT_COLOR:
        UserSettings.I.textColor = color;
        break;

      case BACKGROUND_COLOR:
        UserSettings.I.backgroundColor = color;
        break;
    }
  }

  Color _getColorFromSettings() {
    switch (widget.colorTag) {
      case PRIMARY_COLOR:
        return UserSettings.I.primaryColor;

      case TEXT_COLOR:
        return UserSettings.I.textColor;

      case BACKGROUND_COLOR:
        return UserSettings.I.backgroundColor;

      default:
        return Colors.red;
    }
  }
}
