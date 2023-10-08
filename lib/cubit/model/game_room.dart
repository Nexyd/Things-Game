// To parse this JSON data, do
//
//     final gameRoom = gameRoomFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:things_game/cubit/model/question_board.dart';
import 'package:things_game/widget/model/configuration_data.dart';

class GameRoom {
  String id = "";
  ConfigurationData config;
  List<String> playerList;
  List<QuestionBoard> questionBoard;

  GameRoom({
    required this.id,
    required this.config,
    required this.playerList,
    required this.questionBoard,
  });

  GameRoom copyWith({
    String? id,
    ConfigurationData? config,
    List<String>? playerList,
    List<QuestionBoard>? questionBoard,
  }) {
    return GameRoom(
      id: id ?? this.id,
      config: config ?? this.config,
      playerList: playerList ?? this.playerList,
      questionBoard: questionBoard ?? this.questionBoard,
    );
  }

  factory GameRoom.fromRawJson(String str) =>
      GameRoom.fromJson(json.decode(str));

  factory GameRoom.fromJson(Map<String, dynamic> json) {
    return GameRoom(
      id: json["id"],
      config: ConfigurationData.fromJson(json),
      playerList: List<String>.from(
        json["playerList"].map((x) => x),
      ),
      questionBoard: List<QuestionBoard>.from(
        json["questionBoard"].map(
          (x) => QuestionBoard.fromJson(x),
        ),
      ),
    );
  }

  factory GameRoom.empty() {
    return GameRoom(
      id: "",
      config: ConfigurationData(),
      playerList: [],
      questionBoard: [],
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
      questionBoard: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "config": config.toJson(),
      "playerList": List<dynamic>.from(
        playerList.map((x) => x),
      ),
      "questionBoard": List<dynamic>.from(
        questionBoard.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }

  @override
  bool operator ==(Object other) {
    if (other is! GameRoom) return false;
    return config == other.config;
  }

  @override
  int get hashCode => id.hashCode;
}
