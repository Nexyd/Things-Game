import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/constants.dart';
import 'package:things_game/translations/user_settings_screen.i18n.dart';
import 'package:things_game/widget/avatar_icon.dart';
import 'package:things_game/widget/color_picker.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/widget/styled/styled_text_field.dart';
import 'package:things_game/util/color_utils.dart';

import '../logger.dart';

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
        color: UserSettings.I.backgroundColor,
        child: _getContent(),
      ),
    );
  }

  void _setup() {
    if (UserSettings.I.avatar is! AvatarIcon) {
      isImagePicked = true;
    }

    switch (UserSettings.I.language.languageCode) {
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
          Logger.settings.info("avatar saved!");
        });
      },
      child: isImagePicked ? UserSettings.I.avatar : const AvatarIcon(),
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
    controller.text = UserSettings.I.name;

    return StyledTextField(
      hint: 'Enter user name',
      controller: controller,
      onChanged: (value) {
        final name = controller.value.text;
        _saveToPrefs(NAME, name);
      },
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
          appBar.colorNotifier?.value = UserSettings.I.primaryColor;
        }),
      ),
    );
  }

  Color _getColor(String colorTag) {
    switch (colorTag) {
      case PRIMARY_COLOR:
        return UserSettings.I.primaryColor;

      case TEXT_COLOR:
        return UserSettings.I.textColor;

      case BACKGROUND_COLOR:
        return UserSettings.I.backgroundColor.shade();
    }

    return Colors.transparent;
  }

  Widget _getDropdown() {
    return DropdownButton<String>(
      alignment: Alignment.centerRight,
      dropdownColor: UserSettings.I.backgroundColor,
      focusColor: UserSettings.I.primaryColor,
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
      onChanged: (value) => _saveLanguage(value),
    );
  }

  void _saveLanguage(String? language) {
    switch (language) {
      case "Spanish":
        const locale = Locale("es", "ES");
        I18n.of(context).locale = locale;
        UserSettings.I.language = locale;
        _saveToPrefs(LANGUAGE, "es_ES");
        break;

      case "Español":
        const locale = Locale("es", "ES");
        I18n.of(context).locale = locale;
        UserSettings.I.language = locale;
        _saveToPrefs(LANGUAGE, "es_ES");
        break;

      case "English":
        const locale = Locale("en", "GB");
        I18n.of(context).locale = locale;
        UserSettings.I.language = locale;
        _saveToPrefs(LANGUAGE, "en_GB");
        break;

      case "Inglés":
        const locale = Locale("en", "GB");
        I18n.of(context).locale = locale;
        UserSettings.I.language = locale;
        _saveToPrefs(LANGUAGE, "en_GB");
        break;

      default:
        Logger.settings.warning("Could not save language...");
    }

    setState(() {
      localeStr = language;
      appBar.titleNotifier?.value = "User settings".i18n;
    });
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
          width: AVATAR_SIZE,
          height: AVATAR_SIZE,
          child: Image.file(file),
        );

        _saveToPrefs(AVATAR, path);
        setState(() {
          isImagePicked = true;
        });
      } catch (error) {
        Logger.settings.error("Error trying to parse image path: $path...");
      }
    }

    UserSettings.I.avatar = baseAvatar;
    return baseAvatar;
  }
}
