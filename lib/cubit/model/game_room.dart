import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:things_game/cubit/model/realm_models.dart';
import 'package:things_game/widget/model/configuration_data.dart';

extension GameRoomUtils on GameRoom {
  GameRoom copyWith({
    ConfigurationData? config,
    List<Player>? playerList,
  }) {
    return GameRoom(
      id,
      config: config ?? this.config,
      playerList: playerList ?? this.playerList,
    );
  }

  static GameRoom empty() {
    return GameRoom(
      "",
      config: ConfigurationDataUtils.empty(),
      playerList: [],
    );
  }

  static GameRoom sample() {
    return GameRoom(
      "Id#${Random().nextInt(999)}",
      config: ConfigurationData(
        "Game#${Random().nextInt(999)}",
        Random().nextInt(10),
        Random().nextInt(10),
        Random().nextInt(70),
        Random().nextBool(),
      ),
      playerList: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "config": config?.toJson(),
      "playerList": List<dynamic>.from(playerList.map((x) => x)),
    };
  }

  String toRawJson() => jsonEncode(toJson());

  bool compareTo(Object other) {
    if (other is! GameRoom) return false;
    return config == other.config && listEquals(playerList, other.playerList);
  }
}