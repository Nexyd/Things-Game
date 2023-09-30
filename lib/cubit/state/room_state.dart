import 'package:flutter/material.dart';

import 'package:things_game/cubit/model/game_room.dart';

@immutable
abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomError extends RoomState {
  final String error;

  RoomError({
    required this.error,
  });
}

class RoomCreated extends RoomState {
  final GameRoom room;

  RoomCreated({
    required this.room,
  });
}

class LoadingGameList extends RoomState {}
class RoomListLoaded extends RoomState {
  final List<GameRoom> roomList;
  RoomListLoaded({required this.roomList});
}

class PlayerJoined extends RoomState {
  final String playerName;
  final Image? playerAvatar;

  PlayerJoined({
    required this.playerName,
    this.playerAvatar,
  });
}

class PlayerLeft extends RoomState {
  final String playerName;

  PlayerLeft({
    required this.playerName,
  });
}
