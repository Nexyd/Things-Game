import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/translations/room_settings.i18n.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/styled/styled_text_form_field.dart';
import 'package:things_game/logger.dart';

class RoomSettings extends StatefulWidget {
  final bool isPlayersFieldEnabled;
  final ConfigurationData? config;
  final bool formSubmittable;

  const RoomSettings({
    super.key,
    this.config,
    this.formSubmittable = false,
    this.isPlayersFieldEnabled = true,
  });

  @override
  State<RoomSettings> createState() => RoomSettingsWidgetState();
}

class RoomSettingsWidgetState extends State<RoomSettings> {
  bool light = true;
  bool isFirstCheck = true;
  ConfigurationData config = ConfigurationData();
  late RoomCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<RoomCubit>(context);
    if (widget.config != null) {
      config = widget.config!;
    }

    return Form(
      child: BlocBuilder<RoomCubit, RoomState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is RoomConfigUpdated) {
            config = state.config;
          }

          return Container(
            color: UserSettings.I.backgroundColor,
            child: _getContent(context),
          );
        },
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    final cells = [
      {"Players".i18n: _getTextForm("players")},
      {"Rounds".i18n: _getTextForm("rounds")},
      {"Max. points".i18n: _getTextForm("maxPoints")},
      {"Private".i18n: _getSwitch()},
    ];

    final submitButton = StyledButton(
      text: "Create".i18n,
      onPressed: () {
        if (Form.of(context).validate()) {
          cubit.createRoom();
        }
      },
    );

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: cells.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
        ),
        if (widget.formSubmittable)
          submitButton,
      ],
    );
  }

  Widget _getTextForm(String field) {
    bool isEnabled = field == "players" ? widget.isPlayersFieldEnabled : true;
    return StyledTextForm(
      hint: '',
      initialValue: _getInitialValue(field),
      type: TextInputType.number,
      enabled: isEnabled,
      onChanged: (value) {
        _updateField(
          field,
          int.parse(value),
        );
      },
      validator: (text) => config.validate(
        int.tryParse(text),
        field == "players",
      ),
    );
  }

  String _getInitialValue(String field) {
    String result = "";
    switch (field) {
      case "players":
        result = config.players.toString();
        break;

      case "rounds":
        result = config.rounds.toString();
        break;

      case "maxPoints":
        result = config.maxPoints.toString();
        break;

      default:
        Logger.game.error("Incorrect field data");
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
        config.players = value;
        break;

      case "rounds":
        config.rounds = value;
        break;

      case "maxPoints":
        config.maxPoints = value;
        break;

      default:
        Logger.game.error("Incorrect field data");
        break;
    }

    cubit.updateConfiguration(config);
  }

  Widget _getSwitch() {
    return Switch(
      value: light,
      activeColor: UserSettings.I.primaryColor,
      onChanged: (value) {
        setState(() {
          light = value;
          config.isPrivate = value;
        });
      },
    );
  }
}