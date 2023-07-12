import 'package:flutter/cupertino.dart';

import '../model/game_room.dart';

@immutable
abstract class GameRoomState {}

class GameRoomInitial extends GameRoomState {}

class GameRoomError extends GameRoomState {
  final String error;

  GameRoomError({
    required this.error,
  });
}

class GameRoomCreated extends GameRoomState {
  final GameRoom room;

  GameRoomCreated({
    required this.room,
  });
}

class LoadingGameList extends GameRoomState {}

class GameListLoaded extends GameRoomState {
  // TODO: add game list
  // final List<GameRoom> gameList;
  // GameListLoaded({required this.gameList});
}

class PlayerJoined extends GameRoomState {
  final String playerName;
  final Image? playerAvatar;

  PlayerJoined({
    required this.playerName,
    this.playerAvatar,
  });
}

class PlayerAnswerSent extends GameRoomState {}

class PlayerAssignmentSent extends GameRoomState {}
