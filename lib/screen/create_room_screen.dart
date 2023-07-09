import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/screen/lobby_screen.dart';
import 'package:things_game/translations/game_settings_screen.i18n.dart';
import 'package:things_game/widget/game_settings.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/cubit/game_room_cubit.dart';

import '../cubit/state/game_room_state.dart';
import '../widget/alert_dialog.dart';

class CreateRoomScreen extends StatelessWidget {
  final ConfigurationData data = ConfigurationData();

  CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GameRoomCubit>(context);
    return BlocConsumer<GameRoomCubit, GameRoomState>(
      bloc: cubit,
      builder: (context, state) => _getContent(cubit),
      listenWhen: (previousState, state) {
        return state is GameRoomCreated || state is GameRoomError;
      },
      listener: (context, state) {
        if (state is GameRoomError) {
          BasicDialog(
            title: "Error",
            content: "Ha ocurrido un error",
            buttonMessage: "Aceptar"
          ).show(context);
        } else if (state is GameRoomCreated) {
          print("### navigating to lobby... ###");
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => LobbyScreen(room: state.room),
          //   ),
          // );
        }
      },
    );
  }

  Widget _getContent(GameRoomCubit cubit) {
    final notifier = ValueNotifier<ConfigurationData>(data);
    final key = GlobalKey<GameSettingsState>();

    return Scaffold(
      appBar: StyledAppBar("Create a room".i18n),
      backgroundColor: UserSettings.instance.backgroundColor,
      body: Column(
        children: [
          GameSettings(
            key: key,
            notifier: notifier,
          ),
          StyledButton(
            text: "Create".i18n,
            onPressed: () {
              key.currentState?.refresh();
              if (key.currentState?.validateFields() == true) {
                cubit.createRoom(notifier.value);
              }
            },
          ),
        ],
      ),
    );
  }
}
