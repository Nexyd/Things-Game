import 'package:flutter/material.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/translations/game_settings.i18n.dart';
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
  State<GameSettings> createState() => GameSettingsState();
}

class GameSettingsState extends State<GameSettings> {
  bool light = true;
  bool isFirstCheck = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserSettings.I.backgroundColor,
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
    controller.text = _setInitialValue(field);

    return StyledTextField(
      hint: '',
      controller: controller,
      type: TextInputType.number,
      onChanged: (value) {
        _updateField(
          field,
          int.parse(controller.value.text),
        );
      },
      onError: () => _validate(
        int.tryParse(controller.value.text),
        field == "players",
      ),
    );
  }

  String _setInitialValue(String field) {
    String result = "";
    switch (field) {
      case "players":
        result = widget.notifier.value.players.toString();
        break;

      case "rounds":
        result = widget.notifier.value.rounds.toString();
        break;

      case "maxPoints":
        result = widget.notifier.value.maxPoints.toString();
        break;

      default:
        print("### Incorrect field data ###");
        break;
    }

    if (isFirstCheck) {
      return result == "0" ? "" : result;
    } else {
      return result;
    }
  }

  void _updateField(String field, int value) {
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

    isFirstCheck = false;
  }

  Widget _getSwitch() {
    return Switch(
      value: light,
      activeColor: UserSettings.I.primaryColor,
      onChanged: (bool value) {
        setState(() {
          light = value;
          widget.notifier.value.isPrivate = value;
        });
      },
    );
  }

  String? _validate(int? value, [isNumPlayers = false]) {
    if (isFirstCheck) return null;
    if (value == null) {
      return 'This field is mandatory'.i18n;
    }

    if (isNumPlayers && value < 3) {
      return 'The number of players must be greater than 2'.i18n;
    }

    if (value < 0) {
      return 'The value must be greater than 0'.i18n;
    }

    return null;
  }

  bool validateFields() {
    isFirstCheck = false;
    if (_validate(widget.notifier.value.players, true) != null) {
      return false;
    }

    if (_validate(widget.notifier.value.rounds) != null) {
      return false;
    }

    if (_validate(widget.notifier.value.maxPoints) != null) {
      return false;
    }

    return true;
  }

  void refresh() {
    setState(() {});
  }
}
