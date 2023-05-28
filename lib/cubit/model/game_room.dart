// To parse this JSON data, do
//
//     final gameRoom = gameRoomFromJson(jsonString);

import 'dart:convert';

import 'package:things_game/cubit/model/question_board.dart';

GameRoom gameRoomFromJson(String str) => GameRoom.fromJson(json.decode(str));

String gameRoomToJson(GameRoom data) => json.encode(data.toJson());

class GameRoom {
  int numPlayers;
  int numRounds;
  int maxPoints;
  bool isPrivate;
  List<QuestionBoard> questionBoard;

  GameRoom({
    required this.numPlayers,
    required this.numRounds,
    required this.maxPoints,
    required this.isPrivate,
    required this.questionBoard,
  });

  factory GameRoom.fromJson(
    Map<String, dynamic> json,
  ) {
    return GameRoom(
      numPlayers: json["numPlayers"],
      numRounds: json["numRounds"],
      maxPoints: json["maxPoints"],
      isPrivate: json["isPrivate"],
      questionBoard: List<QuestionBoard>.from(
        json["questionBoard"].map(
          (x) => QuestionBoard.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "numPlayers": numPlayers,
      "numRounds": numRounds,
      "maxPoints": maxPoints,
      "isPrivate": isPrivate,
      "questionBoard": List<dynamic>.from(
        questionBoard.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
