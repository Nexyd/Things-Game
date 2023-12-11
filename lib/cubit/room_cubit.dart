import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/room_repository.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import '../streams/firestore_room_controller.dart';

class RoomCubit extends Cubit<RoomState> {
  GameRoom actualGame = GameRoom.empty();
  final RoomRepository repo = RoomRepository();
  FirestoreRoomController? controller;

  RoomCubit() : super(RoomInitial());

  void updateConfiguration(ConfigurationData data) {
    actualGame = actualGame.copyWith(config: data);
    emit(RoomConfigUpdated(config: actualGame.config));
  }

  Future<void> createRoom() async {
    if (actualGame == GameRoom.empty()) return;
    actualGame.playerList.add(UserSettings.I.name);
    final result = await repo.createRoom(actualGame.toJson());

    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return;
    }

    actualGame.id = result;
    controller = FirestoreRoomController(room: actualGame);
    emit(RoomCreated(room: actualGame));
  }

  Future<void> getOpenRooms() async {
    emit(LoadingGameList());

    final result = await repo.getRooms();
    if (result.isNotEmpty && result.first.containsKey("error")) {
      emit(RoomError(error: result.first.entries.first.value));
      return;
    }

    List<GameRoom> rooms = result.map((e) => GameRoom.fromJson(e)).toList();
    emit(RoomListLoaded(roomList: rooms));
  }

  Future<bool> addPlayer(String name) async {
    print("### room cubit add player ###");
    final result = await repo.updatePlayers(
      actualGame.id,
      actualGame.playerList,
    );

    print("### room cubit add player result: $result ###");
    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return false;
    }

    return true;
  }

  Future<bool> removePlayer(String name) async {
    print("### room cubit remove player ###");
    return false;
  }

  Future<void> deleteRoom() async {
    controller?.dispose();
    final result = await repo.deleteRoom(actualGame.id);
    actualGame = GameRoom.empty();

    if (result != null) {
      emit(RoomError(error: result));
      return;
    }
  }

  void backToMain(BuildContext context) {
    print("### cubit back to main screen ###");
    Navigator.of(context).popUntil(
      (route) => route.settings.name == "/main",
    );
  }
}
