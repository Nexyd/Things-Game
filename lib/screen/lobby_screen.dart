import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/translations/lobby_screen.i18n.dart';
import 'package:things_game/widget/styled/styled_button.dart';
import 'package:things_game/widget/styled/styled_text.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/screen/room_settings_screen.dart';

import '../cubit/game_cubit.dart';

class LobbyScreenArguments {
  final GameRoom initialRoom;

  LobbyScreenArguments(this.initialRoom);
}

class LobbyScreen extends StatefulWidget {
  final LobbyScreenArguments args;

  const LobbyScreen(this.args, {super.key});

  @override
  State<StatefulWidget> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  GameRoom room = GameRoom.empty();
  List<Map<String, Widget>> playerList = [];
  late RoomCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<RoomCubit>(context);
    if (room == GameRoom.empty()) {
      room = widget.args.initialRoom;
    }

    return _getContent(context, cubit);
  }

  Widget _getContent(BuildContext context, RoomCubit cubit) {
    final width = MediaQuery.of(context).size.width / 100 * 90;
    // TODO: fix navigation back in iOS (add button)

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _leaveRoom(context),
      child: Scaffold(
        backgroundColor: UserSettings.I.backgroundColor,
        body: SafeArea(
          child: StreamBuilder(
              stream: cubit.roomStream,
              builder: (context, snapshot) {
                final players = snapshot.data?.data()?.playerList;
                room = room.copyWith(playerList: players);

                return Column(
                  children: [
                    _getHeader(),
                    _getListView(context),
                    _getIndicatorBar(width),
                    _getListTile("rounds"),
                    _getListTile("points"),
                    StyledButton(
                      text: "Start/Ready".i18n,
                      onPressed: () {
                        BlocProvider.of<GameCubit>(context).startGame();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      // TODO: fix button size in iOS
                      child: StyledButton(
                        text: "Leave room".i18n,
                        onPressed: () => _leaveRoom(context),
                        type: ButtonType.destructive,
                      ),
                    ),
                  ],
                );
              }),
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
          // TODO: find a way to shorten id (while still being usable).
          // StyledText("$title: \n${room.id}", fontSize: 30),
          StyledText("$title: \nFoo", fontSize: 30),
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
        final args = RoomSettingsScreenArgs(data: room.config);
        Navigator.of(context).pushNamed("/roomSettings", arguments: args);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: _getDecoration("assets/config.png"),
      ),
    );
  }

  Widget _getListView(BuildContext context) {
    playerList = List.generate(
      room.config.players,
      (index) {
        final playerName = index < room.playerList.length
            ? room.playerList[index]
            : "Player ${index + 1}";

        return {playerName: _getIcon()};
      },
    );

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
        value = room.config.rounds.toString();
        break;

      case "points":
        title = "Max. points".i18n;
        value = room.config.maxPoints.toString();
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

  void _leaveRoom(BuildContext context) {
    cubit.leaveRoom();
    final player = playerList.firstWhere(
      (e) => e.keys.first == UserSettings.I.name,
    );

    playerList.remove(player);
    final players = _getPlayersOnlyList();

    if (players.isEmpty)  cubit.deleteRoom();
    cubit.backToMain(context);
  }

  List<String> _getPlayersOnlyList() {
    // TODO: test with 2 devices
    final players = playerList.map((e) => e.keys.first).toList();
    players.remove("Player 1");
    players.remove("Player 2");
    players.remove("Player 3");
    players.remove("Player 4");

    return players;
  }
}
