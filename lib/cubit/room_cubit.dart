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

  Future<void> updateConfiguration(ConfigurationData data) async {
    _actualGame = _actualGame.copyWith(config: data);
    final result = await _repo.updateConfig(_actualGame.id, data.toJson());

    if (result.error != null) {
      emit(RoomError(error: result.error!));
      return;
    }
  }

  Future<void> createRoom() async {
    if (_actualGame == GameRoom.empty()) return;
    emit(RoomCreationInProgress());

    _actualGame.playerList.add(Player(
      name: UserSettings.I.name,
      uid: UserSettings.I.credentials?.user?.uid,
    ));

    final result = await _repo.createRoom(_actualGame.toJson());
    if (result.error != null) {
      emit(RoomError(error: result.error!));
      return;
    }

    _actualGame.id = result.result!;
    controller = FirestoreRoomController(room: _actualGame);

    emit(RoomCreated(room: _actualGame));
  }

  Future<void> getOpenRooms() async {
    emit(LoadingGameList());

    final result = await _repo.getRooms();
    if (result.error != null) {
      emit(RoomError(error: result.error!));
      return;
    }

    final rooms = result.rooms.map((e) => GameRoom.fromJson(e)).toList();
    emit(RoomListLoaded(roomList: rooms));
  }

  Future<void> updatePlayerReady(List<Player> players) async {
    _actualGame = _actualGame.copyWith(playerList: players);
    _updatePlayers();
  }

  Future<void> joinRoom(GameRoom selectedRoom) async {
    _actualGame = selectedRoom;
    _actualGame.playerList.add(Player(name: UserSettings.I.name));
    return _updatePlayers();
  }

  Future<void> leaveRoom() async {
    // TODO: test with 2 or more devices
    final userToRemove = _actualGame.playerList
        .where((element) => element.name == UserSettings.I.name)
        .toList();

    if (userToRemove.isNotEmpty) {
      _actualGame.playerList.remove(userToRemove.first);
    }

    return _updatePlayers();
  }

  Future<void> _updatePlayers() async {
    final playerList = _actualGame.playerList.map((e) => e.toJson()).toList();
    final result = await _repo.updatePlayers(_actualGame.id, playerList);

    if (result.error != null) {
      emit(RoomError(error: result.error!));
      return;
    }

    emit(PlayerLeft(playerName: UserSettings.I.name));
  }

  Future<void> deleteRoom() async {
    controller?.dispose();
    final result = await _repo.deleteRoom(_actualGame.id);
    _actualGame = GameRoom.empty();

    if (result != null) {
      emit(RoomError(error: result));
    }
  }

  void backToMain(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      if (!context.mounted) return;
      Navigator.of(context).popUntil(
        (route) => route.settings.name == "/main",
      );
    });
  }
}
