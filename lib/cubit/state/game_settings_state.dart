import 'package:flutter/material.dart';

import 'package:things_game/cubit/model/game_room.dart';

@immutable
abstract class GameSettingsState {}

class GameSettingsInitial extends GameSettingsState {}

class GameSettingsError extends GameSettingsState {
  final String error;

  GameSettingsError({
    required this.error,
  });
}

class RoomCreated extends GameSettingsState {
  final GameRoom room;

  RoomCreated({
    required this.room,
  });
}

class LoadingGameList extends GameSettingsState {}
class GameListLoaded extends GameSettingsState {
  final List<GameRoom> gameList;
  GameListLoaded({required this.gameList});
}

class PlayerJoined extends GameSettingsState {
  final String playerName;
  final Image? playerAvatar;

  PlayerJoined({
    required this.playerName,
    this.playerAvatar,
  });
}

class PlayerLeft extends GameSettingsState {
  final String playerName;

  PlayerLeft({
    required this.playerName,
  });
}
