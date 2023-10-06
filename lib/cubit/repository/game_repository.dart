import 'package:things_game/cubit/repository/dio_repository.dart';

class GameRepository extends DioRepository {
  Future<bool> sendMessage(
    String id,
    List<String> playerList,
  ) async {
    // final response = await client.put(
    //   id,
    //   data: jsonEncode(<String, dynamic>{
    //     QUESTION_BOARD: boardJson,
    //   }),
    // );

    return false;
  }

  Future<bool> announceAnswers(
    String id,
    String boardJson,
  ) async {
    // final response = await client.put(
    //   id,
    //   data: jsonEncode(<String, dynamic>{
    //     QUESTION_BOARD: boardJson,
    //   }),
    // );

    // TODO: parse response.
    return false;
  }

  Future<bool> sendAssignments(
    String playerName,
    List<String> playerAssignment,
  ) async {
    // final response = await client.post(
    //   id,
    //   data: jsonEncode(<String, dynamic>{
    //     QUESTION_BOARD: boardJson,
    //   }),
    // );

    // TODO: parse response.
    return false;
  }
}
