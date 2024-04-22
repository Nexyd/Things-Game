import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
import 'package:things_game/cubit/model/player.dart';
import 'package:things_game/cubit/model/test_model.dart';
import 'package:things_game/streams/streamable_mixin.dart';
import 'package:things_game/widget/model/configuration_data.dart';

//extension GameRoomMethods on GameRoom with Streamable<GameRoom> {
extension GameRoomMethods on GameRoom { //}with Streamable<GameRoom> {
  GameRoom copyWith({
    ConfigurationData? config,
    List<Player>? playerList,
  }) {
    return GameRoom(
      id: id,
      config: config ?? this.config,
      playerList: playerList ?? this.playerList,
    );
  }

  factory GameRoom.fromRawJson(String str) =>
      GameRoom.fromJson(json.decode(str));

  factory GameRoom.fromJson(Map<String, dynamic> json) {
    List<Player> players = [];
    for (var element in (json["playerList"] as List)) {
      players.add(Player.fromJson(element));
    }

    return GameRoom(
      id: json["id"] ?? "",
      config: ConfigurationData.fromJson(json["config"]),
      playerList: players,
    );
  }

  factory GameRoom.empty() {
    return GameRoom(
      id: "",
      config: ConfigurationData(),
      playerList: [],
    );
  }

  factory GameRoom.sample() {
    return GameRoom(
      id: "Id#${Random().nextInt(999)}",
      config: ConfigurationData(
        name: "Game#${Random().nextInt(999)}",
        players: Random().nextInt(10),
        rounds: Random().nextInt(10),
        maxPoints: Random().nextInt(70),
        isPrivate: Random().nextBool(),
      ),
      playerList: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "config": config.toJson(),
      "playerList": List<dynamic>.from(playerList.map((x) => x)),
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  bool compareTo(Object other) {
    if (other is! GameRoom) return false;
    return config == other.config && listEquals(playerList, other.playerList);
  }

  @override
  int get hashCode => id.hashCode;
}




// class GameRoom with Streamable<GameRoom> {
//   String id;
//   ConfigurationData config;
//   List<Player> playerList;
//
//   GameRoom({
//     required this.id,
//     required this.config,
//     required this.playerList,
//   });
//
//   GameRoom copyWith({
//     ConfigurationData? config,
//     List<Player>? playerList,
//   }) {
//     return GameRoom(
//       id: id,
//       config: config ?? this.config,
//       playerList: playerList ?? this.playerList,
//     );
//   }
//
//   factory GameRoom.fromRawJson(String str) =>
//       GameRoom.fromJson(json.decode(str));
//
//   factory GameRoom.fromJson(Map<String, dynamic> json) {
//     List<Player> players = [];
//     for (var element in (json["playerList"] as List)) {
//       players.add(Player.fromJson(element));
//     }
//
//     return GameRoom(
//       id: json["id"] ?? "",
//       config: ConfigurationData.fromJson(json["config"]),
//       playerList: players,
//     );
//   }
//
//   factory GameRoom.empty() {
//     return GameRoom(
//       id: "",
//       config: ConfigurationData(),
//       playerList: [],
//     );
//   }
//
//   factory GameRoom.sample() {
//     return GameRoom(
//       id: "Id#${Random().nextInt(999)}",
//       config: ConfigurationData(
//         name: "Game#${Random().nextInt(999)}",
//         players: Random().nextInt(10),
//         rounds: Random().nextInt(10),
//         maxPoints: Random().nextInt(70),
//         isPrivate: Random().nextBool(),
//       ),
//       playerList: [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "config": config.toJson(),
//       "playerList": List<dynamic>.from(playerList.map((x) => x)),
//     };
//   }
//
//   String toRawJson() => jsonEncode(toJson());
//
//   @override
//   bool operator ==(Object other) {
//     if (other is! GameRoom) return false;
//     return config == other.config && listEquals(playerList, other.playerList);
//   }
//
//   @override
//   int get hashCode => id.hashCode;
// }
