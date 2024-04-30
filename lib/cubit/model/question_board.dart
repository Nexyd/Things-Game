import 'package:things_game/cubit/model/realm_models.dart';

import 'assignment.dart';

class QuestionBoard {
  late QuestionBoardDB _db;

  QuestionBoardDB get db => _db;

  // Get attributes
  String get question => _db.question;

  Map<String, dynamic> get answers => _db.answers;

  List<Assignment> get assignments =>
      _db.assignments.toList().map((e) => Assignment.fromDB(e)).toList();

  // Set attributes
  set question(String value) => _db.realm.write(() => _db.question = value);

  set answers(Map<String, dynamic> value) {
    _db.answers.clear();
    // TODO: think how to do this.
    //_db.answers.addAll(value.map((e) => e.db));
  }

  set assignments(List<Assignment> value) {
    _db.assignments.clear();
    _db.assignments.addAll(value.map((e) => e.db));
  }

  QuestionBoard({
    required String question,
    required Map<String, dynamic> answers,
    required List<Assignment> assignments,
  }) {
    // TODO: get data from DB
    _db = QuestionBoardDB();

    this.question = question;
    this.answers = answers;
    this.assignments = assignments;
  }

  factory QuestionBoard.fromDB(QuestionBoardDB db) {
    final assignments =
        db.assignments.toList().map((e) => Assignment.fromDB(e));

    return QuestionBoard(
      question: db.question,
      answers: db.answers,
      assignments: assignments.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "answers": answers,
      "assignments": List<dynamic>.from(
        assignments.map((x) => x.toJson()),
      ),
    };
  }
}
