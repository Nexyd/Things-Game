import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/translations/game_settings_screen.i18n.dart';
import 'package:things_game/widget/game_settings.dart';
import 'package:things_game/widget/styled/styled_app_bar.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/cubit/game_room_cubit.dart';

class CreateRoomScreen extends StatelessWidget {
  final ConfigurationData data = ConfigurationData();

  CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: this will be useful for posterior screens (lobby / game)
    // return BlocConsumer<GameRoomCubit, GameRoomState>(
    //     //bloc: userRegisterCubit,
    //     builder: (context, state) => Container(),
    //     listenWhen: (previousState, state) {
    //       return state is UserRegisterSuccess;
    //     },
    //     listener: (context, state) {
    //       if (state is UserRegisterSuccess) {
    //         Navigator.of(context).pop();
    //       }
    //     },
    // );

    return _getContent(context);
  }

  Widget _getContent(BuildContext context) {
    final cubit = BlocProvider.of<GameRoomCubit>(context);
    final notifier = ValueNotifier<ConfigurationData>(data);

    return Scaffold(
      appBar: StyledAppBar("Game settings".i18n),
      backgroundColor: UserSettings.instance.backgroundColor,
      body: Column(
        children: [
          GameSettings(
            notifier: notifier,
          ),
          StyledButton(
            text: "Create".i18n,
            onPressed: () {
              cubit.createRoom(notifier.value);
            },
          ),
        ],
      ),
    );
  }
}
