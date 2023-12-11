import 'dart:convert';
import 'dart:math';

import 'package:things_game/cubit/model/question_board.dart';
import 'package:things_game/streams/streamable_mixin.dart';

class GameBoard with Streamable<GameBoard> {
  String id;
  List<QuestionBoard> questionBoard;

  GameBoard({required this.id, required this.questionBoard});

  GameBoard copyWith({List<QuestionBoard>? questionBoard}) {
    return GameBoard(
      id: id,
      questionBoard: questionBoard ?? this.questionBoard,
    );
  }

  factory GameBoard.fromRawJson(String str) =>
      GameBoard.fromJson(json.decode(str));

  factory GameBoard.fromJson(Map<String, dynamic> json) {
    return GameBoard(
      id: json["id"] ?? "",
      questionBoard: List<QuestionBoard>.from(
        json["questionBoard"].map(
          (x) => QuestionBoard.fromJson(x),
        ),
      ),
    );
  }

  factory GameBoard.empty() => GameBoard(id: "", questionBoard: []);

  factory GameBoard.sample() {
    return GameBoard(id: "Id#${Random().nextInt(999)}", questionBoard: []);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "questionBoard": List<dynamic>.from(
        questionBoard.map((x) => x.toJson()),
      ),
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) {
    if (other is! GameBoard) return false;
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
