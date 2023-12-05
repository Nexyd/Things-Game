import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pastebin/pastebin.dart';
import 'package:things_game/cubit/repository/dio_repository.dart';

import '../../support/constants.dart';
import '../../support/logger.dart';

class PastebinRepository extends DioRepository {
  final userKey = "2d7a99b044ec751a72423a9ab2c9b4da";
  final pastebin = withSingleApiDevKey(
    apiDevKey: "KMyCYinFCWJDdNlTQRYhYBDz2kLog4vB",
  );

  @override
  get baseUrl => "https://pastebin.com";

  @override
  get rawBaseUrl => "https://pastebin.com/raw";

  Future<String> createRoom(
    String roomJson, [
    bool isPrivate = false,
  ]) async {
    final response = await pastebin.paste(
      pasteText: roomJson,
      options: PasteOptions(
        apiUserKey: userKey,
        pasteVisiblity: Visibility.unlisted,
      ),
    );

    String result = "";
    response.fold(
      (error) => result = "error: $error",
      (value) => result = value.toString(),
    );

    return result;
  }

  Future<List<String>> getRooms() async {
    final response = await pastebin.pastes(userKey: userKey);
    List<String> roomUrls = [];

    response.fold(
      (error) => roomUrls.add("error: $error"),
      (value) => roomUrls = value.map((e) => e.url.toString()).toList(),
    );

    if (roomUrls.isNotEmpty && roomUrls.first.startsWith("error")) {
      Logger.room.error("Error retrieving rooms: ${roomUrls.first}");
      return roomUrls;
    }

    return _getJsonList(roomUrls);
  }

  Future<String> updatePlayers(String id, List<String> playerList) async {
    print("### repo update players ###");

    try {
      final response = await client.put(
        "E2ShwDNR", //id,
        data: jsonEncode(<String, dynamic>{
          PLAYER_LIST: playerList,
        }),
      );

      print("### response: $response ###");
    } on DioError catch (error) {
      Logger.game.error("DioError: $error");
      return Future.error(error);
    } catch (error) {
      Logger.game.error("Error: $error");
      return Future.error(error);
    }

    // TODO: parse response.data
    return "";
  }

  Future<String> updateBoard(String id, String boardJson) async {
    // final response = await client.put(
    //   id,
    //   data: jsonEncode(<String, dynamic>{
    //     QUESTION_BOARD: boardJson,
    //   }),
    // );

    // TODO: parse response.
    return "";
  }

  Future<String> deleteRoom(String id) async {
    //final response = await pastebin.delete(id);

    // TODO: parse response.
    return "";
  }

  Future<List<String>> _getJsonList(List<String> roomUrls) async {
    List<String> result = [];
    for (String url in roomUrls) {
      final rawUrl = url.replaceFirst(baseUrl, rawBaseUrl);
      final id = url.substring(
        url.lastIndexOf("/") + 1,
      );

      final response = await getRawJson(rawUrl);
      final json = _addIdToJson(id, response);

      result.add(json);
    }

    return result;
  }

  String _addIdToJson(String id, String json) {
    String result = json.substring(0, json.length - 1);
    result = "$result,\"id\": \"$id\"}";

    return result;
  }
}
