import 'dart:convert';
import 'dart:math';

import 'package:realm/realm.dart';
import 'package:things_game/model/question_board.dart';
import 'package:things_game/model/realm_models.dart';

// class GameBoard with Streamable<GameBoard> {
class GameBoard {
  late GameBoardDB _db;

  GameBoard({
    required String roomId,
    required List<QuestionBoard> questionBoard,
  }) {
    // TODO: get data from DB
    _db = GameBoardDB(ObjectId());

    this.roomId = roomId;
    this.questionBoard = questionBoard;
  }

  GameBoard copyWith({List<QuestionBoard>? questionBoard}) {
    return GameBoard(
      roomId: roomId,
      questionBoard: questionBoard ?? this.questionBoard,
    );
  }

  factory GameBoard.empty() => GameBoard(roomId: "", questionBoard: []);

  factory GameBoard.sample() {
    return GameBoard(roomId: "Id#${Random().nextInt(999)}", questionBoard: []);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": roomId,
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

extension GameBoardUtilsDB on GameBoard {
  // Get attributes
  String get id => _db.id.hexString;

  String get roomId => _db.roomId;

  List<QuestionBoard> get questionBoard =>
      _db.questionBoard.toList().map((e) => QuestionBoard.fromDB(e)).toList();

  // Set attributes
  set roomId(String value) => _db.realm.write(() => _db.roomId = value);
  // set id(String value) => _db.realm.write(() => _db.id = value);

  set questionBoard(List<QuestionBoard> value) {
    _db.questionBoard.clear();
    _db.questionBoard.addAll(value.map((e) => e.db));
  }
}
