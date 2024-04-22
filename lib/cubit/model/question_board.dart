import 'package:things_game/cubit/model/realm_models.dart';

extension QuestionBoardUtils on QuestionBoard {
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

extension AssignmentUtils on Assignment {
  Map<String, dynamic> toJson() {
    return {
      "playerName": playerName,
      "playerAssignment": playerAssignment
    };
  }
}