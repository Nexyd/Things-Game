import 'package:things_game/cubit/model/game_room.dart';

class ConfigurationData {
  String name;
  int players;
  int rounds;
  int maxPoints;
  bool isPrivate;

  ConfigurationData({
    this.name = "",
    this.players = 0,
    this.rounds = 0,
    this.maxPoints = 0,
    this.isPrivate = true,
  });

  ConfigurationData copyWith({GameRoom? room}) {
    return ConfigurationData(
      name: room?.name ?? name,
      players: room?.numPlayers ?? players,
      rounds: room?.numRounds ?? rounds,
      maxPoints: room?.maxPoints ?? maxPoints,
      isPrivate: room?.isPrivate ?? isPrivate,
    );
  }
}
