import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_room_repository.dart';
import 'package:things_game/cubit/state/game_settings_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class GameSettingsCubit extends Cubit<GameSettingsState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRoomRepository repo = GameRoomRepository();

  GameSettingsCubit() : super(GameSettingsInitial());

  Future<void> createRoom(ConfigurationData data) async {
    actualGame = actualGame.copyWith(
      numPlayers: data.players,
      numRounds: data.rounds,
      maxPoints: data.maxPoints,
      isPrivate: data.isPrivate,
    );

    const result = "https://pastebin.com/BjYFu9CW";
    // final result = await repo.createRoom(
    //   actualGame.toJson().toString(),
    // );

    if (result.startsWith("error")) {
      emit(GameSettingsError(error: result));
      return;
    }

    actualGame.id = result.substring(
      result.lastIndexOf("/") + 1,
    );

    emit(RoomCreated(room: actualGame));
  }

  Future<void> getOpenRooms() async {
    emit(LoadingGameList());

    final result = await repo.getRooms();
    print("### open rooms: $result ###");

    emit(GameListLoaded(
      gameList: [
        GameRoom.sample(),
        GameRoom.sample(),
        GameRoom.sample(),
      ],
    ));
  }

  Future<bool> addPlayer(String name) async {
    print("### cubit add player ###");
    final result = await repo.updatePlayers(
      actualGame.id,
      actualGame.playerList,
    );

    print("### cubit add player result: $result ###");
    return false;
  }

  Future<bool> removePlayer(String name) async {
    print("### cubit remove player ###");
    return false;
  }

  void startGame() {
    addPlayer("foo");
    print("### cubit Game Started! ###");
  }

  Future<bool> deleteRoom() async {
    print("### cubit delete room ###");
    return false;
  }

  void backToMain(BuildContext context) {
    print("### cubit back to main screen ###");
    Navigator.of(context).popUntil(
      (route) => route.settings.name == "/main",
    );
  }
}
