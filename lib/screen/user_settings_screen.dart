import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/constants.dart';
import 'package:things_game/translations/user_settings_screen.i18n.dart';
import 'package:things_game/util/debouncer.dart';
import 'package:things_game/widget/avatar_icon.dart';
import 'package:things_game/widget/color_picker.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_text.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool isImagePicked = false;
  String? localeStr = "Spanish".i18n;
  final StyledAppBar appBar = StyledAppBar("User settings".i18n);

  @override
  Widget build(BuildContext context) {
    _setup();
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: UserSettings.instance.backgroundColor,
        child: _getContent(),
      ),
    );
  }

  void _setup() {
    if (UserSettings.instance.avatar is! AvatarIcon) {
      isImagePicked = true;
    }

    switch (UserSettings.instance.language.languageCode) {
      case "en":
        localeStr = "English".i18n;
        break;

      case "es":
        localeStr = "Spanish".i18n;
        break;
    }
  }

  Widget _getContent() {
    Widget icon = InkWell(
      onTap: () {
        _pickAvatar().then((value) {
          debugPrint("### avatar saved! ###");
        });
      },
      child: isImagePicked ? UserSettings.instance.avatar : const AvatarIcon(),
    );

    final cells = [
      {"Name".i18n: _getTextField()},
      {"Avatar".i18n: icon},
      {"Primary color".i18n: _getColorIcon(PRIMARY_COLOR)},
      {"Text color".i18n: _getColorIcon(TEXT_COLOR)},
      {"Background color".i18n: _getColorIcon(BACKGROUND_COLOR)},
      {"Language".i18n: _getDropdown()},
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
      child: ColorPickerWrapper(
        colorTag: tag,
        callback: () => setState(() {
          appBar.colorNotifier?.value = UserSettings.instance.primaryColor;
        }),
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

  Widget _getDropdown() {
    return DropdownButton<String>(
      alignment: Alignment.centerRight,
      dropdownColor: UserSettings.instance.backgroundColor,
      focusColor: UserSettings.instance.primaryColor,
      underline: Container(),
      items: [
        DropdownMenuItem(
          value: "Spanish".i18n,
          child: StyledText("Spanish".i18n),
        ),
        DropdownMenuItem(
          value: "English".i18n,
          child: StyledText("English".i18n),
        ),
      ],
      value: localeStr,
      onChanged: (value) {
        debugPrint("### Changed value to: $value ###");
        _saveLanguage(value);
      },
    );
  }

  void _saveLanguage(String? language) {
    switch (language) {
      case "Spanish":
        const locale = Locale("es", "ES");
        I18n.of(context).locale = locale;
        UserSettings.instance.language = locale;
        _saveToPrefs(LANGUAGE, "es_ES");
        break;

      case "Español":
        const locale = Locale("es", "ES");
        I18n.of(context).locale = locale;
        UserSettings.instance.language = locale;
        _saveToPrefs(LANGUAGE, "es_ES");
        break;

      case "English":
        const locale = Locale("en", "GB");
        I18n.of(context).locale = locale;
        UserSettings.instance.language = locale;
        _saveToPrefs(LANGUAGE, "en_GB");
        break;

      case "Inglés":
        const locale = Locale("en", "GB");
        I18n.of(context).locale = locale;
        UserSettings.instance.language = locale;
        _saveToPrefs(LANGUAGE, "en_GB");
        break;

      default:
        debugPrint("### Could not save language... ###");
    }

    setState(() {
      localeStr = language;
      appBar.titleNotifier?.value = "User settings".i18n;
    });
  }

  Future<void> _saveToPrefs(String tag, String name) async {
    debugPrint("### Saving \"$name\" in entry: \"$tag\"... ###");
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
          width: AVATAR_SIZE,
          height: AVATAR_SIZE,
          child: Image.file(file),
        );

        _saveToPrefs(AVATAR, path);
        setState(() {
          isImagePicked = true;
        });
      } catch (error) {
        debugPrint("### Error trying to parse image path: $path... ###");
      }
    }

    UserSettings.instance.avatar = baseAvatar;
    return baseAvatar;
  }
}
