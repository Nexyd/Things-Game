import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/translations/lobby_screen.i18n.dart';
import 'package:things_game/widget/model/configuration_data.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/game_room_cubit.dart';
import 'package:things_game/cubit/state/game_room_state.dart';

import 'game_settings_screen.dart';

class LobbyScreenArguments {
  final GameRoom room;

  LobbyScreenArguments(this.room);
}

class LobbyScreen extends StatefulWidget {
  final LobbyScreenArguments args;

  const LobbyScreen(
    this.args, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  List<Map<String, Widget>> playerList = [];

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GameRoomCubit>(context);
    return BlocConsumer<GameRoomCubit, GameRoomState>(
      bloc: cubit,
      builder: (context, state) => _getContent(cubit),
      listenWhen: (previousState, state) {
        return state is PlayerJoined;
      },
      listener: (context, state) {
        state as PlayerJoined;
        final player = playerList.firstWhere(
          (element) => element.keys.first.startsWith("Player"),
        );

        setState(() {
          playerList.remove(player);
          playerList.insert(1, {
            state.playerName: _getIcon(true),
          });
        });
      },
    );
  }

  Widget _getContent(GameRoomCubit cubit) {
    final width = MediaQuery.of(context).size.width / 100 * 90;

    return Scaffold(
      backgroundColor: UserSettings.I.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _getHeader(),
            _getListView(context),
            _getIndicatorBar(width),
            _getListTile("rounds"),
            _getListTile("points"),
            StyledButton(
              text: "Start/Ready".i18n,
              onPressed: () => cubit.startGame(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: StyledButton(
                text: "Leave room".i18n,
                onPressed: () => cubit.backToMain(context),
                type: ButtonType.destructive,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    final title = "Lobby id".i18n;
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          StyledText(
            "$title: \n${widget.args.room.id}",
            fontSize: 30,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: _getConfigButton(context),
          ),
        ],
      ),
    );
  }

  Widget _getConfigButton(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        // TODO: Pass key to get back the new settings value.
        // TODO: remove or add players to the list according to new settings.
        final configData = ConfigurationData().copyWith(
          room: widget.args.room,
        );

        Navigator.of(context)
            .pushNamed(
              "/gameSettings",
              arguments: GameSettingsScreenArgs(configData),
            )
            .then((value) => setState(() {}));
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: _getDecoration(
          "assets/config.png",
        ),
      ),
    );
  }

  Widget _getListView(BuildContext context) {
    if (playerList.isEmpty) {
      playerList
        ..add({UserSettings.I.name: _getIcon()})
        ..add({"Player 1": _getIcon()})
        ..add({"Player 2": _getIcon()})
        ..add({"Player 3": _getIcon()});
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: playerList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: UserSettings.I.avatar,
                title: StyledText(playerList[index].keys.first),
                trailing: playerList[index].values.first,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getIndicatorBar(double width) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 1,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.5),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _getListTile(String tag) {
    String title = "";
    String value = "";

    switch (tag) {
      case "rounds":
        title = "Rounds".i18n;
        value = widget.args.room.numRounds.toString();
        break;

      case "points":
        title = "Max. points".i18n;
        value = widget.args.room.maxPoints.toString();
        break;

      default:
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListTile(
        title: StyledText(title),
        trailing: StyledText(value),
      ),
    );
  }

  Widget _getIcon([bool isReady = false]) {
    return isReady
        ? const Icon(Icons.done, color: Colors.green)
        : const Icon(Icons.close, color: Colors.red);
  }

  BoxDecoration _getDecoration(String asset) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(asset),
        colorFilter: ColorFilter.mode(
          UserSettings.I.primaryColor,
          BlendMode.srcIn,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}
