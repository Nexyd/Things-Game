import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/translations/configuration.i18n.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/styled/styled_text_field.dart';

class ConfigurationData {
  int players;
  int rounds;
  int maxPoints;

  ConfigurationData({
    this.players = 0,
    this.rounds  = 0,
    this.maxPoints = 0,
  });
}

class GameSettings extends StatefulWidget {
  final ValueNotifier<ConfigurationData> notifier;

  const GameSettings({
    super.key,
    required this.notifier,
  });

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserSettings.instance.backgroundColor,
      child: _getContent(),
    );
  }

  Widget _getContent() {
    final cells = [
      {"Players".i18n: _getTextField()},
      {"Rounds".i18n:  _getTextField()},
      {"Max. points".i18n: _getTextField()},
      {"Private".i18n: _getSwitch()},
    ];

    // final cells = [
    //   {"Players".i18n: const StyledTextField(hint: '')},
    //   {"Rounds".i18n:  const StyledTextField(hint: '')},
    //   {"Max. points".i18n: const StyledTextField(hint: '')},
    //   // {"Private".i18n: _getColorIcon(TEXT_COLOR)},
    // ];

    return ListView.builder(
      itemCount: cells.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == cells.length - 1) {
          return ListTile(
            leading: StyledText(cells[index].keys.first),
            trailing: cells[index].values.first,
            style: ListTileStyle.list,
          );
        } else {
          return ListTile(
            leading: StyledText(cells[index].keys.first),
            title: cells[index].values.first,
          );
        }
      },
    );
  }

  Widget _getTextField() {
    return StyledTextField(
      hint: '',
      onChanged: () {
        print("### config data - "
          "players: ${widget.notifier.value.players}, "
          "rounds: ${widget.notifier.value.rounds}, "
          "max points: ${widget.notifier.value.maxPoints} "
        "###");
      },
    );
  }

  Widget _getSwitch() {
    return Switch(
      value: light,
      activeColor: UserSettings.instance.primaryColor,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
