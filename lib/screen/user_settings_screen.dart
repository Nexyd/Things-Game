import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/avatar_icon.dart';
import 'package:things_game/widget/color_picker.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/util/debouncer.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StyledAppBar("User settings"),
      body: Container(
        color: UserSettings.instance.backgroundColor,
        child: _getContent(),
      ),
    );
  }

  Widget _getContent() {
    Widget icon = InkWell(
      // TODO: open image picker.
      onTap: () => print("### Avatar pressed ###"),
      child: const AvatarIcon(),
    );

    final cells = [
      {"Name": _getTextField()},
      {"Avatar": icon},
      {"Primary color": _getColorIcon("primaryColor")},
      {"Text color": _getColorIcon("textColor")},
      {"Background color": _getColorIcon("backgroundColor")},
      //{"Language": _getColorIcon("")},
    ];

    return ListView.builder(
      itemCount: cells.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return ListTile(
            leading: StyledText(cells[index].keys.first),
            title: cells[index].values.first,
          );
        } else {
          return ListTile(
            leading: StyledText(cells[index].keys.first),
            trailing: cells[index].values.first,
            style: ListTileStyle.list,
          );
        }
      },
    );
  }

  Widget _getTextField() {
    TextEditingController controller = TextEditingController();
    final debouncer = Debouncer(milliseconds: 500);
    controller.text = UserSettings.instance.name;

    return TextField(
      controller: controller,
      onChanged: (text) {
        final name = controller.value.text;
        debouncer.run(() {
          debugPrint("### save name: $name to prefs... ###");
          _saveToPrefs(name);
        });
      },
      style: TextStyle(color: UserSettings.instance.textColor),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: UserSettings.instance.textColor,
          ),
        ),
        hintText: 'Enter user name',
        hintStyle: TextStyle(
          color: UserSettings.instance.textColor,
        ),
      ),
    );
  }

  Widget _getColorIcon(String tag) {
    const double iconSize = 25;
    return Container(
      decoration: BoxDecoration(
        color: _getColor(tag),
        borderRadius: BorderRadius.circular(
          iconSize / 2,
        ),
      ),
      width: iconSize,
      height: iconSize,
      child: CustomColorPicker(
        colorTag: tag,
      ),
    );
  }

  Color _getColor(String colorTag) {
    switch (colorTag) {
      case "primaryColor":
        return UserSettings.instance.primaryColor;

      case "textColor":
        return UserSettings.instance.textColor;

      case "backgroundColor":
        return _getBackground();
    }

    return Colors.transparent;
  }

  Color _getBackground() {
    final color = UserSettings.instance.backgroundColor;
    return Color.fromRGBO(
      color.red <= 245 ? color.red + 10 : color.red - 10,
      color.green <= 245 ? color.green + 10 : color.green - 10,
      color.blue <= 245 ? color.blue + 10 : color.blue - 10,
      color.opacity,
    );
  }

  Future<void> _saveToPrefs(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
  }
}
