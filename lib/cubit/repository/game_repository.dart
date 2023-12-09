import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/cubit/repository/dio_repository.dart';

class GameRepository extends DioRepository {
  final boardsDb = FirebaseFirestore.instance.collection("boards");

  Future<bool> sendMessage(
    String id,
    List<String> playerList,
  ) async {
    return false;
  }

  Future<bool> announceAnswers(
    String id,
    String boardJson,
  ) async {
    return false;
  }

  Future<bool> sendAssignments(
    String playerName,
    List<String> playerAssignment,
  ) async {
    return false;
  }
}
