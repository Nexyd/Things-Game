import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pastebin/pastebin.dart';
import 'package:things_game/constants.dart';

class GameRoomRepository {
  late Dio client;
  final pastebin = withSingleApiDevKey(
    apiDevKey: "KMyCYinFCWJDdNlTQRYhYBDz2kLog4vB",
  );

  GameRoomRepository() {
    client = _getClient();
  }

  Future<String> createRoom(String roomJson) async {
    final result = await pastebin.paste(pasteText: roomJson);
    String resultString = "";

    result.fold(
      (error) => resultString = "error: $error",
      (value) => resultString = value.toString(),
    );

    return resultString;
  }

  Future<String> updatePlayers(
    String id,
    List<String> playerList,
  ) async {
    final response = await client.put(
      id,
      data: jsonEncode(<String, dynamic>{
        PLAYER_LIST: playerList,
      }),
    );

    // TODO: parse response.data
    return "";
  }

  Future<String> updateBoard(
    String id,
    String boardJson,
  ) async {
    final response = await client.put(
      id,
      data: jsonEncode(<String, dynamic>{
        QUESTION_BOARD: boardJson,
      }),
    );

    // TODO: parse response.
    return "";
  }

  Future<String> deleteRoom(String id) async {
    final response = await client.delete(id);

    // TODO: parse response.
    return "";
  }

  Dio _getClient() {
    client = Dio(
      BaseOptions(
        baseUrl: 'https://pastebin.com/raw/',
        receiveDataWhenStatusError: true,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );

    client.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

    return client;
  }
}
