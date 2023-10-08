import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_switch.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/translations/room_settings.i18n.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/widget/styled/styled_text_form_field.dart';
import 'package:things_game/logger.dart';

class RoomSettings extends StatelessWidget {
  final ConfigurationData config;
  final bool isPlayersFieldEnabled;
  final bool formSubmittable;

  const RoomSettings({
    super.key,
    required this.config,
    this.formSubmittable = false,
    this.isPlayersFieldEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: BlocBuilder<RoomCubit, RoomState>(
        bloc: BlocProvider.of<RoomCubit>(context),
        builder: (context, state) {
          if (state is RoomConfigUpdated) {
            config.name = state.config.name;
            config.players = state.config.players;
            config.rounds = state.config.rounds;
            config.maxPoints = state.config.maxPoints;
            config.isPrivate = state.config.isPrivate;
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
    final switchButton = StyledSwitch(
      value: config.isPrivate,
      onChanged: (value) => config.isPrivate = value,
    );

    final cells = [
      {"Room name".i18n: _getTextForm("name", context)},
      {"Players".i18n: _getTextForm("players", context)},
      {"Rounds".i18n: _getTextForm("rounds", context)},
      {"Max. points".i18n: _getTextForm("maxPoints", context)},
      {"Private".i18n: switchButton},
    ];

    final submitButton = StyledButton(
      text: "Create".i18n,
      onPressed: () {
        if (Form.of(context).validate()) {
          BlocProvider.of<RoomCubit>(context).createRoom();
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
        if (formSubmittable) submitButton,
      ],
    );
  }

  Widget _getTextForm(String field, BuildContext context) {
    callback(String value) {
      if (field == "name") {
        config.name = value;
      } else {
        _updateField(
          field,
          int.parse(value),
        );
      }

      BlocProvider.of<RoomCubit>(context).updateConfiguration(config);
    }

    return StyledTextForm(
      hint: '',
      initialValue: _getInitialValue(field),
      type: TextInputType.number,
      enabled: field == "players" ? isPlayersFieldEnabled : true,
      onChanged: callback,
      validator: (text) {
        if (field == "name") {
          return null;
        }

        return config.validate(
          int.tryParse(text),
          field == "players",
        );
      },
    );
  }

  String _getInitialValue(String field) {
    String result = "";
    switch (field) {
      case "name":
        result = config.name;
        break;

      case "players":
        final players = config.players.toString();
        result = players == "0" ? "" : players;
        break;

      case "rounds":
        final rounds = config.rounds.toString();
        result = rounds == "0" ? "" : rounds;
        break;

      case "maxPoints":
        final maxPoints = config.maxPoints.toString();
        result = maxPoints == "0" ? "" : maxPoints;
        break;

      default:
        Logger.game.error("Incorrect field data");
        break;
    }

    return result;
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
  }
}
