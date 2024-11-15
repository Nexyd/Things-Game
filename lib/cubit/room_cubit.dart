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

  Future<void> createRoom(ConfigurationData config) async {
    if (config.isEmpty) return;
    _actualGame = _actualGame.copyWith(config: config);
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

    _actualGame.id = result.id!;
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
  }

  Future<void> deleteRoom() async {
    print("### disposing firestore controller... ###");
    controller?.dispose();

    print("### removing from repo... ###");
    final result = await _repo.deleteRoom(_actualGame.id);

    print("### repo result: $result ###");
    _actualGame = GameRoom.empty();

    if (result != null) {
      print("### result error: $result ###");
      emit(RoomError(error: result));
    }

    print("### room deleted ###");
  }

  void backToMain(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      if (!context.mounted) return;
      Navigator.of(context).popUntil(
        (route) => route.settings.name == "/main",
      );
    });
  }

  void removePlayer() {
    print("### finding player... ###");
    final userToRemove = _actualGame.playerList
        .where((element) => element.name == UserSettings.I.name)
        .toList();

    print("### player: ${userToRemove.map((e) => e.name)} ###");
    if (userToRemove.isNotEmpty) {
      _actualGame.playerList.remove(userToRemove.first);
    }

    print("### getting player list... ###");
    final playerList = _actualGame.playerList.map((e) => e.toJson()).toList();
    print("### updating players to $playerList on id: ${_actualGame.id} ###");
    _repo.removePlayer(_actualGame.id, playerList);
  }
}
