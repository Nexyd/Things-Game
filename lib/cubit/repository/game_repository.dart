import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/cubit/repository/room_repository.dart';

class GameRepository {
  final _boardsDb = FirebaseFirestore.instance.collection("boards");

  Future<String> createBoard(Json roomJson) async {
    print("### game repository create board ###");
    String result = "";
    final boardJson = {
      "id": "foo",
      "questionBoard": [
        {
          "id": 1,
          "question": "Lorem impsum?",
          "answers": {
            "player1": "Lorem lorem",
            "player2": "No tan lorem",
            "player3": "Un poco lorem",
            "player4": "Lorem impsum"
          },
          "assignments": [
            {
              "playerName": "player1",
              "playerAssignment": {
                "player4": "No tan lorem",
                "player2": "Un poco lorem",
                "player3": "Lorem impsum"
              }
            },
            {
              "playerName": "player2",
              "playerAssignment": {
                "player3": "No tan lorem",
                "player4": "Lorem lorem",
                "player1": "Lorem impsum"
              }
            }
          ]
        }
      ]
    };

    await _boardsDb
        .add(boardJson)
        .then((value) => result = value.id)
        .catchError((error) => result = "Error: $error");

    return result;
  }

  Future<bool> sendMessage(
    String id,
    List<String> playerList,
  ) async {
    print("### game repository send message ###");
    return false;
  }

  Future<bool> announceAnswers(
    String id,
    String boardJson,
  ) async {
    print("### game repository announce answers ###");
    return false;
  }

  Future<bool> sendAssignments(
    String playerName,
    List<String> playerAssignment,
  ) async {
    print("### game repository send assignments ###");
    return false;
  }
}
