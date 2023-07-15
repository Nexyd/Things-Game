// To parse this JSON data, do
//
//     final gameRoom = gameRoomFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:things_game/cubit/model/question_board.dart';

GameRoom gameRoomFromJson(String str) => GameRoom.fromJson(json.decode(str));

String gameRoomToJson(GameRoom data) => json.encode(data.toJson());

class GameRoom {
  String id = "";
  String name;
  int numPlayers;
  int numRounds;
  int maxPoints;
  bool isPrivate;
  List<String> playerList;
  List<QuestionBoard> questionBoard;

  GameRoom({
    required this.name,
    required this.numPlayers,
    required this.numRounds,
    required this.maxPoints,
    required this.isPrivate,
    required this.playerList,
    required this.questionBoard,
  });

  GameRoom copyWith({
    String? name,
    int? numPlayers,
    int? numRounds,
    int? maxPoints,
    bool? isPrivate,
    List<String>? playerList,
    List<QuestionBoard>? questionBoard,
  }) {
    return GameRoom(
      name: name ?? this.name,
      numPlayers: numPlayers ?? this.numPlayers,
      numRounds: numRounds ?? this.numRounds,
      maxPoints: maxPoints ?? this.maxPoints,
      isPrivate: isPrivate ?? this.isPrivate,
      playerList: playerList ?? this.playerList,
      questionBoard: questionBoard ?? this.questionBoard,
    );
  }

  factory GameRoom.fromJson(
    Map<String, dynamic> json,
  ) {
    return GameRoom(
      name: json["name"],
      numPlayers: json["numPlayers"],
      numRounds: json["numRounds"],
      maxPoints: json["maxPoints"],
      isPrivate: json["isPrivate"],
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
      name: "",
      numPlayers: 0,
      numRounds: 0,
      maxPoints: 0,
      isPrivate: true,
      playerList: [],
      questionBoard: [],
    );
  }

  factory GameRoom.sample() {
    var sample = GameRoom(
      name: "Game#${Random().nextInt(999)}",
      numPlayers: Random().nextInt(10),
      numRounds: Random().nextInt(10),
      maxPoints: Random().nextInt(70),
      isPrivate: Random().nextBool(),
      playerList: [],
      questionBoard: [],
    );

    sample.id = "${Random().nextInt(9999)}";
    return sample;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "numPlayers": numPlayers,
      "numRounds": numRounds,
      "maxPoints": maxPoints,
      "isPrivate": isPrivate,
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
    return name == other.name &&
        numPlayers == other.numPlayers &&
        numRounds == other.numRounds &&
        maxPoints == other.maxPoints &&
        isPrivate == other.isPrivate;

    //other is GameRoom && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => 0;
}
