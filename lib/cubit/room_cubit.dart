import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/config/user_settings.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/cubit/repository/room_repository.dart';
import 'package:things_game/cubit/state/room_state.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import 'model/realm_models.dart';

class RoomCubit extends Cubit<RoomState> {
  GameRoom _actualGame = GameRoomUtils.empty();
  final RoomRepository _repo = RoomRepository();
  // FirestoreRoomController? controller;
  //
  // Stream<DocumentSnapshot<GameRoom>>? get roomStream =>
  //     controller?.roomRef.snapshots();

  RoomCubit() : super(RoomInitial());

  Future<void> updateConfiguration(ConfigurationData data) async {
    _actualGame = _actualGame.copyWith(config: data);
    final result = await _repo.updateConfig(_actualGame.id, data.toJson());

    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return;
    }
  }

  // TODO: look for a way to remove this.
  void updateConfigSwitch(ConfigurationData data) {
    _actualGame = _actualGame.copyWith(config: data);
    // TODO: Check nullability (should be removed)
    emit(RoomConfigUpdated(config: _actualGame.config!));
  }

  Future<void> createRoom() async {
    if (_actualGame == GameRoomUtils.empty()) return;
    // TODO: add default parameter to Player RealmModel
    _actualGame.playerList.add(Player(name: UserSettings.I.name));
    final result = await _repo.createRoom(_actualGame.toJson());

    if (result.startsWith("error")) {
      emit(RoomError(error: result));
      return;
    }

    // TODO: search for a way to autogenerate IDs
    _actualGame.id = result;
    //controller = FirestoreRoomController(room: _actualGame);

    emit(RoomCreated(room: _actualGame));
  }

  Future<void> getOpenRooms() async {
    emit(LoadingGameList());

    final result = await _repo.getRooms();
    if (result.isNotEmpty && result.first.containsKey("error")) {
      emit(RoomError(error: result.first.entries.first.value));
      return;
    }

    //TODO: Review this when MongoDB is ready
    //List<GameRoom> rooms = result.map((e) => GameRoom.fromJson(e)).toList();

    List<GameRoom> rooms = [];
    emit(RoomListLoaded(roomList: rooms));
  }

  Future<void> updatePlayerReady(List<Player> players) async {
    _actualGame = _actualGame.copyWith(playerList: players);
    _updatePlayers();
  }

  Future<bool> joinRoom(GameRoom selectedRoom) async {
    _actualGame = selectedRoom;
    // TODO: add default parameter to Player RealmModel
    _actualGame.playerList.add(Player(name: UserSettings.I.name));
    return _updatePlayers();
  }

  Future<bool> leaveRoom() async {
    // TODO: test with 2 devices
    final userToRemove = _actualGame.playerList
        .where((element) => element.name == UserSettings.I.name)
        .toList();

    if (userToRemove.isNotEmpty) {
      _actualGame.playerList.remove(userToRemove.first);
    }

    return _updatePlayers();
  }

  Future<bool> _updatePlayers() async {
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

  Future<void> deleteRoom() async {
    //controller?.dispose();
    final result = await _repo.deleteRoom(_actualGame.id);
    _actualGame = GameRoomUtils.empty();

    if (result != null) {
      emit(RoomError(error: result));
      return;
    }
  }

  void backToMain(BuildContext context) {
    // TODO: fix navigation problems with PopScope.
    Future.delayed(const Duration(milliseconds: 200)).then(
      (value) => Navigator.of(context).popUntil(
        (route) => route.settings.name == "/main",
      ),
    );
  }
}
