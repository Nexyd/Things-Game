import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/theme_switcher_cubit.dart';
import 'package:things_game/support/constants.dart';
import 'package:things_game/support/logger.dart';
import 'package:things_game/translations/user_settings_screen.i18n.dart';
import 'package:things_game/util/debouncer.dart';
import 'package:things_game/util/color_utils.dart';
import 'package:things_game/widget/avatar_icon.dart';
import 'package:things_game/widget/color_picker.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/widget/styled/styled_text_field.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  ThemeSwitcherCubit? cubit;
  bool isImagePicked = false;
  String? localeStr = "Spanish".i18n;
  final StyledAppBar appBar = StyledAppBar("User settings".i18n);

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of(context);

    _setup();
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: _getContent(context),
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

  Widget _getContent(BuildContext context) {
    Widget icon = InkWell(
      onTap: () => _pickAvatar().then((value) {
        Logger.settings.info("avatar saved!");
      }),
      child: isImagePicked ? UserSettings.I.avatar : const AvatarIcon(),
    );

    // TODO: Replace maps to Records?
    final cells = [
      {"Name".i18n: _getTextField()},
      {"Avatar".i18n: icon},
      {"Primary color".i18n: _getColorIcon(PRIMARY_COLOR)},
      {"Text color".i18n: _getColorIcon(TEXT_COLOR)},
      {"Background color".i18n: _getColorIcon(BACKGROUND_COLOR)},
      {"Language".i18n: _getDropdown(context)},
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
    final debouncer = Debouncer(milliseconds: 500);
    TextEditingController controller = TextEditingController();
    controller.text = UserSettings.I.name;

    return StyledTextField(
      hint: 'Enter user name',
      controller: controller,
      onChanged: (value) => debouncer.run(() {
        _saveToPrefs(NAME, controller.value.text);
      }),
    );
  }

  Widget _getColorIcon(String tag) {
    const double iconSize = 25;
    return Container(
      decoration: BoxDecoration(
        color: _getColor(tag),
        borderRadius: BorderRadius.circular(iconSize / 2),
      ),
      width: iconSize,
      height: iconSize,
      child: ColorPickerWrapper(
        colorTag: tag,
        callback: () => setState(() {
          cubit?.updateTheme();
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

  Widget _getDropdown(BuildContext context) {
    return DropdownButton<String>(
      alignment: Alignment.centerRight,
      dropdownColor: Theme.of(context).colorScheme.secondary,
      focusColor: Theme.of(context).primaryColor,
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
      onChanged: (value) => _updateLanguage(value),
    );
  }

  void _updateLanguage(String? language) {
    switch (language) {
      case "Spanish":
        _saveLanguage(ESP_LANG);
        break;

      case "Español":
        _saveLanguage(ESP_LANG);
        break;

      case "English":
        _saveLanguage(ENG_LANG);
        break;

      case "Inglés":
        _saveLanguage(ENG_LANG);
        break;

      default:
        Logger.settings.warning("Could not save language...");
    }

    setState(() {
      localeStr = language;
      appBar.titleNotifier?.value = "User settings".i18n;
    });
  }

  void _saveLanguage(String localeStr) {
    final splitLocale = localeStr.split("_");
    final locale = Locale(splitLocale[0], splitLocale[1]);
    I18n.of(context).locale = locale;
    UserSettings.I.language = locale;
    _saveToPrefs(LANGUAGE, localeStr);
  }

  Future<void> _saveToPrefs(String tag, String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tag, name).then((saved) {
      if (saved) UserSettings.I.name = name;
      Logger.prefs.info("Saving value: $name to $tag, result: $saved");
    });
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
        setState(() => isImagePicked = true);
      } catch (error) {
        Logger.settings.error("Error trying to parse image path: $path...");
      }
    }

    UserSettings.I.avatar = baseAvatar;
    return baseAvatar;
  }
}
