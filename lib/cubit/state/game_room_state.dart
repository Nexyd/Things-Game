import 'package:flutter/cupertino.dart';

@immutable
abstract class GameRoomState {}

class GameRoomInitial extends GameRoomState {}

class GameRoomError extends GameRoomState {}

class PlayerJoined extends GameRoomState {}

class PlayerAnswerSent extends GameRoomState {}

class PlayerAssignmentSent extends GameRoomState {}