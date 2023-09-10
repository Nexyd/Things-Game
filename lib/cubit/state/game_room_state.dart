import 'package:flutter/material.dart';

@immutable
abstract class GameRoomState {}

class GameRoomInitial extends GameRoomState {}
class GameRoomError extends GameRoomState {
  final String error;

  GameRoomError({
    required this.error,
  });
}

class PlayerAnswerSent extends GameRoomState {}

class PlayerAssignmentSent extends GameRoomState {}
