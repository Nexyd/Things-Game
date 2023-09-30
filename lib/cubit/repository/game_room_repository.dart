import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pastebin/pastebin.dart';
import 'package:things_game/constants.dart';

class GameRoomRepository {
  late Dio client;
  final baseUrl = "https://pastebin.com";
  final rawBaseUrl = "https://pastebin.com/raw";
  //final userKey = "9bf04d6fed8c18ff03d257a0ba6864e0";
  final userKey = "2d7a99b044ec751a72423a9ab2c9b4da";
  final pastebin = withSingleApiDevKey(
    apiDevKey: "KMyCYinFCWJDdNlTQRYhYBDz2kLog4vB",
  );

  GameRoomRepository() {
    client = _getClient();
  }

  Future<String> login() async {
    String key = "";
    final result = await pastebin.apiUserKey(
      username: "Nexyd",
      password: "AndusinTwilight12",
    );

    result.fold(
      (error) => key = "error happened: $error",
      (value) => key = value,
    );

    return key;
  }

  Future<String> createRoom(
    String roomJson, [
    bool isPrivate = false,
  ]) async {
    final response = await pastebin.paste(
      pasteText: roomJson,
      options: PasteOptions(
        apiUserKey: userKey,
        pasteVisiblity: isPrivate ? Visibility.private : Visibility.unlisted,
        //pasteVisiblity: Visibility.unlisted,
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
      // (value) => value.map((e) async => await getRawJson(e.url.toString()))
    );

    if (roomUrls.isNotEmpty && roomUrls.first.startsWith("error")) {
      // TODO: Add Loggy, and print error here.
      return roomUrls;
    }

    return _getJsonList(roomUrls);
  }

  Future<String> updatePlayers(
    String id,
    List<String> playerList,
  ) async {
    print("### repo update players ###");

    try {
      final response = await client.put(
        id,
        data: jsonEncode(<String, dynamic>{
          PLAYER_LIST: playerList,
        }),
      );

      print("### response: $response ###");
    } on DioError catch (error) {
      print("### DioError: $error ###");
      return Future.error(error);
    } catch (error) {
      print("### Error: $error ###");
      return Future.error(error);
    }

    // TODO: parse response.data
    return "";
  }

  Future<String> updateBoard(
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
    return "";
  }

  Future<String> deleteRoom(String id) async {
    //final response = await client.delete(id);

    // TODO: parse response.
    return "";
  }

  Future<String> _getRawJson(String url) async {
    final response = await client.get(url);
    return response.data;
  }

  String _addIdToJson(String id, String json) {
    String result = json.substring(0, json.length - 1);
    result = "$result,\"id\": \"$id\"}";

    return result;
  }

  Future<List<String>> _getJsonList(List<String> roomUrls) async {
    List<String> result = [];
    for (String url in roomUrls) {
      final rawUrl = url.replaceFirst(baseUrl, rawBaseUrl);
      final id = url.substring(
        url.lastIndexOf("/") + 1,
      );

      final response = await _getRawJson(rawUrl);
      final json = _addIdToJson(id, response);

      result.add(json);
    }

    return result;
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
