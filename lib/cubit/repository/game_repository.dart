import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/cubit/repository/room_repository.dart';

class GameRepository {
  final boardsDb = FirebaseFirestore.instance.collection("boards");

  Future<String> createBoard(Json roomJson) async {
    print("### game repository create board ###");
    return "";
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
