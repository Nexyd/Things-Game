import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:things_game/streams/streamable_mixin.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class GameRoom with Streamable<GameRoom> {
  String id;
  ConfigurationData config;
  List<String> playerList;

  GameRoom({
    required this.id,
    required this.config,
    required this.playerList,
  });

  GameRoom copyWith({
    ConfigurationData? config,
    List<String>? playerList,
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
    return GameRoom(
      id: json["id"] ?? "",
      config: ConfigurationData.fromJson(json["config"]),
      playerList: List<String>.from(json["playerList"] as List),
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
      "config": config.toJson(),
      "playerList": List<dynamic>.from(playerList.map((x) => x)),
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) {
    if (other is! GameRoom) return false;
    return config == other.config && listEquals(playerList, other.playerList);
  }

  @override
  int get hashCode => id.hashCode;
}
