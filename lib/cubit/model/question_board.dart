import 'package:realm/realm.dart';

import 'assignment.dart';

// part 'question_board.realm.dart';
//
// @RealmModel()
// class _QuestionBoard {
//   late String question;
//   late Map<String, dynamic> answers;
//   late List<Assignment> assignments;
// }



// class QuestionBoard {
//   String question;
//   Map<String, dynamic> answers;
//   List<Assignment> assignments;
//
//   QuestionBoard({
//     required this.question,
//     required this.answers,
//     required this.assignments,
//   });
//
//   factory QuestionBoard.fromJson(Map<String, dynamic> json) {
//     return QuestionBoard(
//       question: json["question"],
//       answers: json["answers"],
//       assignments: List<Assignment>.from(
//         json["assignments"].map((x) => Assignment.fromJson(x)),
//       ),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "question": question,
//       "answers": answers,
//       "assignments": List<dynamic>.from(
//         assignments.map((x) => x.toJson()),
//       ),
//     };
//   }
// }
