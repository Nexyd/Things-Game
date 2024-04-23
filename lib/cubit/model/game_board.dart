import 'dart:convert';
import 'dart:math';

import 'package:things_game/cubit/model/question_board.dart';
import 'package:things_game/cubit/model/realm_models.dart';

extension GameBoardUtils on GameBoard {
  GameBoard copyWith({List<QuestionBoard>? questionBoard}) {
    return GameBoard(
      id: id,
      questionBoard: questionBoard ?? this.questionBoard,
    );
  }

  static GameBoard empty() => GameBoard(id: "", questionBoard: []);

  static GameBoard sample() {
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

  bool compareTo(Object other) {
    if (other is! GameBoard) return false;
    return id == other.id;
  }
}
