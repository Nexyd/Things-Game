import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pastebin/pastebin.dart';
import 'package:things_game/constants.dart';

class GameRoomRepository {
  late Dio client;
  final userKey = "9bf04d6fed8c18ff03d257a0ba6864e0";
  final pastebin = withSingleApiDevKey(
    apiDevKey: "KMyCYinFCWJDdNlTQRYhYBDz2kLog4vB",
  );

  GameRoomRepository() {
    client = _getClient();
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
