import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/screen/lobby_screen.dart';
import 'package:things_game/translations/room_settings_screen.i18n.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/alert_dialog.dart';
import 'package:things_game/widget/model/configuration_data.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/room_settings.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RoomCubit>(context);
    return BlocConsumer<RoomCubit, RoomState>(
      bloc: cubit,
      builder: (context, state) => _getContent(cubit),
      listenWhen: (previous, current) {
        return current is RoomError || current is RoomCreated;
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
    return Scaffold(
      appBar: StyledAppBar("Create a room".i18n),
      backgroundColor: UserSettings.I.backgroundColor,
      body: const RoomSettings(formSubmittable: true),
    );
  }
}
