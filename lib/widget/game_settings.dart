import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/translations/configuration.i18n.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/styled/styled_text_field.dart';

class ConfigurationData {
  int players;
  int rounds;
  int maxPoints;
  bool isPrivate;

  ConfigurationData({
    this.players = 0,
    this.rounds = 0,
    this.maxPoints = 0,
    this.isPrivate = true,
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
      {"Players".i18n: _getTextField("players")},
      {"Rounds".i18n: _getTextField("rounds")},
      {"Max. points".i18n: _getTextField("maxPoints")},
      {"Private".i18n: _getSwitch()},
    ];

    return ListView.builder(
      shrinkWrap: true,
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

  Widget _getTextField(String field) {
    TextEditingController controller = TextEditingController();
    return StyledTextField(
      hint: '',
      controller: controller,
      onChanged: (value) {
        updateField(
          field,
          int.parse(controller.value.text),
        );

        print(
          "### config data - "
          "players: ${widget.notifier.value.players}, "
          "rounds: ${widget.notifier.value.rounds}, "
          "max points: ${widget.notifier.value.maxPoints} "
          "###",
        );
      },
    );
  }

  void updateField(String field, int value) {
    switch (field) {
      case "players":
        widget.notifier.value.players = value;
        break;

      case "rounds":
        widget.notifier.value.rounds = value;
        break;

      case "maxPoints":
        widget.notifier.value.maxPoints = value;
        break;

      default:
        print("### Incorrect field data ###");
        break;
    }
  }

  Widget _getSwitch() {
    return Switch(
      value: light,
      activeColor: UserSettings.instance.primaryColor,
      onChanged: (bool value) {
        setState(() {
          light = value;
          widget.notifier.value.isPrivate = value;
        });
      },
    );
  }
}
