import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/room_cubit.dart';
import 'package:things_game/support/app_lifecycle_manager.dart';
import 'package:things_game/support/logger.dart';
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
  void initState() {
    super.initState();
    AppLifecycleManager.initState(
      // FIXME: this runs when the app is killed, but the user is not removed.
      onExit: () => _handleExitCleanup(),
    );
  }

  @override
  void dispose() {
    AppLifecycleManager.I.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<RoomCubit>(context);
    if (room == GameRoom.empty()) {
      room = widget.args.initialRoom;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => _leaveRoom(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SafeArea(
          child: StreamBuilder(
            stream: cubit.roomStream,
            builder: (context, snapshot) {
              // TODO: updates with new users only appear on some devices.
              final players = snapshot.data?.data()?.playerList;
              room = room.copyWith(playerList: players);

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
          padding: const EdgeInsets.symmetric(vertical: 15.0),
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
      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: StyledText("$title: \n${room.id}", fontSize: 30),
              ),
            ),
          ),
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
        decoration: _getDecoration(context, "assets/config.png"),
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

    final physics = players.length < 9 ? NeverScrollableScrollPhysics() : null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 170,
          maxHeight: 480,
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: physics,
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
    // TODO: update isReady on firestore
    return isReady
        ? const Icon(Icons.done, color: Colors.green)
        : const Icon(Icons.close, color: Colors.red);
  }

  BoxDecoration _getDecoration(BuildContext context, String asset) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(asset),
        colorFilter: ColorFilter.mode(
          Theme.of(context).primaryColor,
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

    cubit.updatePlayerReady(room.playerList);
    if (user.isReady && !playersReady.contains(UserSettings.I.name)) {
      playersReady.add(UserSettings.I.name);
    } else if (!user.isReady && playersReady.contains(UserSettings.I.name)) {
      playersReady.remove(UserSettings.I.name);
    }
  }

  void _leaveRoom(BuildContext context) {
    try {
      cubit.leaveRoom();
      _removePlayer();
    } catch (error) {
      Logger.room.error("Error trying to exit room: $error");
    } finally {
      cubit.backToMain(context);
    }
  }

  void _removePlayer() {
    final player = players.firstWhere(
      (e) => e.keys.first == UserSettings.I.name,
    );

    players.remove(player);
    print("### checking remaining players... ###");
    if (_getPlayersOnlyList().isEmpty) {
      print("### removing room... ###");
      cubit.deleteRoom();
    }
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

  void _handleExitCleanup() {
    print("### leaving room... ###");
    cubit.removePlayer();

    print("### removing local player... ###");
    _removePlayer();
  }
}
