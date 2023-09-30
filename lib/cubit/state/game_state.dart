import 'package:flutter/material.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}
class GameError extends GameState {
  final String error;

  GameError({
    required this.error,
  });
}

class PlayerAnswerSent extends GameState {}

class PlayerAssignmentSent extends GameState {}
