import 'assignment.dart';

class QuestionBoard {
  String question;
  List<String> answers;
  List<Assignment> assignments;

  QuestionBoard({
    required this.question,
    required this.answers,
    required this.assignments,
  });

  factory QuestionBoard.fromJson(Map<String, dynamic> json) {
    return QuestionBoard(
      question: json["question"],
      answers: List<String>.from(json["answers"].map((x) => x)),
      assignments: List<Assignment>.from(
        json["assignments"].map((x) => Assignment.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "answers": List<dynamic>.from(answers.map((x) => x)),
      "assignments": List<dynamic>.from(
        assignments.map((x) => x.toJson()),
      ),
    };
  }
}
