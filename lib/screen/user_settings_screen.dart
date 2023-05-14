import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/avatar_icon.dart';
import 'package:things_game/widget/color_picker.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/util/debouncer.dart';
import 'package:things_game/constants.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool isImagePicked = false;
  Widget avatar = const AvatarIcon();

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
      onTap: () {
        _pickAvatar().then((value) {
          debugPrint("### avatar saved! ###");
        });
      },
      child: isImagePicked ? avatar : const AvatarIcon(),
    );

    final cells = [
      {"Name": _getTextField()},
      {"Avatar": icon},
      {"Primary color": _getColorIcon(PRIMARY_COLOR)},
      {"Text color": _getColorIcon(TEXT_COLOR)},
      {"Background color": _getColorIcon(BACKGROUND_COLOR)},
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
          _saveToPrefs(NAME, name);
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
      case PRIMARY_COLOR:
        return UserSettings.instance.primaryColor;

      case TEXT_COLOR:
        return UserSettings.instance.textColor;

      case BACKGROUND_COLOR:
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

  Future<void> _saveToPrefs(String tag, String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tag, name);
  }

  Future<Widget> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Widget baseAvatar = const AvatarIcon();
    final path = result?.files.single.path;

    if (path != null) {
      try {
        final file = File(path);
        baseAvatar = SizedBox(
          width: 40,
          height: 40,
          child: Image.file(file),
        );

        _saveToPrefs(AVATAR, path);
        setState(() {
          isImagePicked = true;
          avatar = baseAvatar;
        });
      } catch (error) {
        debugPrint("### Error trying to parse image path: $path... ###");
      }
    }

    UserSettings.instance.avatar = baseAvatar;
    return baseAvatar;
  }
}
