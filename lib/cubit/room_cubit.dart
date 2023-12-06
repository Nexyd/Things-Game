import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/game_room_repository.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class RoomCubit extends Cubit<RoomState> {
  GameRoom actualGame = GameRoom.empty();
  final GameRoomRepository repo = GameRoomRepository();

  RoomCubit() : super(RoomInitial());

  void updateConfiguration(ConfigurationData data) {
    actualGame = actualGame.copyWith(config: data);
    emit(RoomConfigUpdated(config: actualGame.config));
  }

  Future<void> createRoom() async {
    if (actualGame == GameRoom.empty()) return;
    //const result = "QcKEDJi8";

    final result = await repo.createRoom(actualGame.toJson());
    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return;
    }

    actualGame.id = result.substring(result.lastIndexOf("/") + 1);
    emit(RoomCreated(room: actualGame));
  }

  Future<void> getOpenRooms() async {
    emit(LoadingGameList());

    final result = await repo.getRooms();
    if (result.isNotEmpty && result.first.startsWith("error")) {
      emit(RoomError(error: result.first));
      return;
    }

    List<GameRoom> rooms = result.map((e) => GameRoom.fromRawJson(e)).toList();
    emit(RoomListLoaded(roomList: rooms));
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
