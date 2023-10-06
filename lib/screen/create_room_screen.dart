import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/screen/lobby_screen.dart';
import 'package:things_game/translations/room_settings_screen.i18n.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/alert_dialog.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import '../cubit/room_cubit.dart';
import '../cubit/state/room_state.dart';
import '../widget/room_settings.dart';

class CreateRoomScreen extends StatelessWidget {
  final ConfigurationData data = ConfigurationData();

  CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RoomCubit>(context);
    return BlocConsumer<RoomCubit, RoomState>(
      bloc: cubit,
      builder: (context, state) => _getContent(cubit),
      listenWhen: (previousState, state) {
        return state is RoomCreated || state is RoomError;
      },
      listener: (context, state) {
        if (state is RoomError) {
          ErrorDialog(context).show();
        } else if (state is RoomCreated) {
          Navigator.of(context).pushNamed(
            "/lobby",
            arguments: LobbyScreenArguments(state.room),
          );
        }
      },
    );
  }

  Widget _getContent(RoomCubit cubit) {
    // TODO: change to cubit ??
    final notifier = ValueNotifier<ConfigurationData>(data);
    final key = GlobalKey<RoomSettingsWidgetState>();

    return Scaffold(
      appBar: StyledAppBar("Create a room".i18n),
      backgroundColor: UserSettings.I.backgroundColor,
      // TODO: replace with BlocConsumer with RoomConfigUpdatedState ??
      body: Column(
        children: [
          RoomSettings(
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
