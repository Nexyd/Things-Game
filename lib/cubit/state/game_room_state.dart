import 'package:flutter/cupertino.dart';

@immutable
abstract class GameRoomState {}

class GameRoomInitial extends GameRoomState {}

class GameRoomError extends GameRoomState {}

class LoadingGameList extends GameRoomState {}

class GameListLoaded extends GameRoomState {
  // TODO: add game list
  // final List<GameRoom> gameList;
  // GameListLoaded({required this.gameList});
}

class PlayerJoined extends GameRoomState {}

class PlayerAnswerSent extends GameRoomState {}

class PlayerAssignmentSent extends GameRoomState {}
