import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/room_repository.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import '../streams/firestore_room_controller.dart';

class RoomCubit extends Cubit<RoomState> {
  GameRoom _actualGame = GameRoom.empty();
  final RoomRepository _repo = RoomRepository();
  FirestoreRoomController? controller;
  Stream<DocumentSnapshot<GameRoom>>? get roomStream =>
      controller?.roomRef.snapshots();

  RoomCubit() : super(RoomInitial());

  void updateConfiguration(ConfigurationData data) {
    _actualGame = _actualGame.copyWith(config: data);
    emit(RoomConfigUpdated(config: _actualGame.config));
  }

  Future<void> createRoom() async {
    if (_actualGame == GameRoom.empty()) return;
    _actualGame.playerList.add(UserSettings.I.name);
    final result = await _repo.createRoom(_actualGame.toJson());

    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return;
    }

    // TODO: search for a way to autogenerate IDs
    _actualGame.id = result;
    controller = FirestoreRoomController(room: _actualGame);
    emit(RoomCreated(room: _actualGame));
  }

  Future<void> getOpenRooms() async {
    emit(LoadingGameList());

    final result = await _repo.getRooms();
    if (result.isNotEmpty && result.first.containsKey("error")) {
      emit(RoomError(error: result.first.entries.first.value));
      return;
    }

    List<GameRoom> rooms = result.map((e) => GameRoom.fromJson(e)).toList();
    emit(RoomListLoaded(roomList: rooms));
  }

  Future<bool> joinRoom(GameRoom selectedRoom, String name) async {
    _actualGame = selectedRoom;
    _actualGame.playerList.add(name);

    final result = await _repo.updatePlayers(
      _actualGame.id,
      _actualGame.playerList,
    );

    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return false;
    }

    return true;
  }

  Future<bool> leaveRoom(String name) async {
    print("### room cubit leave room ###");
    return false;
  }

  Future<void> deleteRoom() async {
    controller?.dispose();
    final result = await _repo.deleteRoom(_actualGame.id);
    _actualGame = GameRoom.empty();

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
