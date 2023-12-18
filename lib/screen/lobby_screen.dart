import 'package:flutter/foundation.dart';
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
  List<Map<String, Widget>> players = [];
  List<String> playersReady = [];
  late RoomCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<RoomCubit>(context);
    if (room == GameRoom.empty()) {
      room = widget.args.initialRoom;
    }

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
              // final players = snapshot.data?.data()?.playerList;
              // room = room.copyWith(playerList: players);
              room = snapshot.data?.data() ?? room;
              return _getContent(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    return Column(
      children: [
        _getHeader(),
        _getListView(context),
        _getIndicatorBar(),
        _getListTile("rounds"),
        _getListTile("points"),
        StyledButton(
          text: "Start/Ready".i18n,
          onPressed: () => _startGame(),
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
        if (players.first.keys.first == UserSettings.I.name) {
          final args = RoomSettingsScreenArgs(data: room.config);
          Navigator.of(context).pushNamed("/roomSettings", arguments: args);
        }
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: _getDecoration("assets/config.png"),
      ),
    );
  }

  Widget _getListView(BuildContext context) {
    players = List.generate(
      room.config.players,
      (index) {
        final playerName = index < room.playerList.length
            ? room.playerList[index].name
            : "Player ${index + 1}";

        final playerIcon = index < room.playerList.length
            ? _getIcon(room.playerList[index].isReady)
            : _getIcon();

        return {playerName: playerIcon};
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
            itemCount: players.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: UserSettings.I.avatar,
                title: StyledText(players[index].keys.first),
                trailing: players[index].values.first,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getIndicatorBar() {
    final width = MediaQuery.of(context).size.width / 100 * 90;
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

  void _startGame() {
    final roomLeader = players.first.keys.first;
    final allPlayersReady = playersReady.length == room.config.players &&
        listEquals(room.playerList, playersReady);

    if (roomLeader == UserSettings.I.name && allPlayersReady) {
      BlocProvider.of<GameCubit>(context).startGame();
    } else {
      _setPlayerReady();
    }
  }

  void _setPlayerReady() {
    final index = room.playerList.indexWhere(
      (element) => element.name == UserSettings.I.name,
    );

    room.playerList[index].isReady = !room.playerList[index].isReady;
    final userToUpdate = players.firstWhere(
      (element) => element.keys.first == UserSettings.I.name,
    );

    final user = room.playerList[index];
    userToUpdate.update(
      UserSettings.I.name,
      (value) => _getIcon(user.isReady),
    );

    // TODO: update ready on Firestore.
    cubit.updatePlayerReady(room.playerList);
    if (user.isReady && !playersReady.contains(UserSettings.I.name)) {
      playersReady.add(UserSettings.I.name);
    } else if (!user.isReady && playersReady.contains(UserSettings.I.name)) {
      playersReady.remove(UserSettings.I.name);
    }
  }

  void _leaveRoom(BuildContext context) {
    cubit.leaveRoom();
    final player = players.firstWhere(
      (e) => e.keys.first == UserSettings.I.name,
    );

    players.remove(player);
    final playersOnly = _getPlayersOnlyList();

    if (playersOnly.isEmpty) cubit.deleteRoom();
    cubit.backToMain(context);
  }

  List<String> _getPlayersOnlyList() {
    // TODO: test with 2 devices
    final playersOnly = players.map((e) => e.keys.first).toList();
    playersOnly.remove("Player 1");
    playersOnly.remove("Player 2");
    playersOnly.remove("Player 3");
    playersOnly.remove("Player 4");

    return playersOnly;
  }
}
