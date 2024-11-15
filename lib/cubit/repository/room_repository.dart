import 'package:cloud_firestore/cloud_firestore.dart';

import '../../support/constants.dart';
import '../../support/logger.dart';
import '../model/game_room.dart';

typedef Json = Map<String, dynamic>;
typedef DocData = QueryDocumentSnapshot<Map<String, dynamic>>;
typedef RoomListResponse = ({List<Json> rooms, String? error});
typedef RoomRepoResponse = ({String? id, String? error});

class RoomRepository {
  late final CollectionReference<Map<String, dynamic>> _roomsDb;

  RoomRepository() {
    _roomsDb = FirebaseFirestore.instance.collection("rooms");
  }

  Future<RoomRepoResponse> createRoom(Json roomJson) async {
    String? id;
    String? error;

    Logger.repository.info("Creating room with json: $roomJson");

    await _roomsDb
        .add(roomJson)
        .then((value) => id = value.id)
        .catchError((error) => error = "$error");

    final response = (id: id, error: error);
    if (response.error != null) {
      Logger.repository.error("Error creating room: $error");
      return response;
    }

    // TODO: search for a way to autogenerate IDs (or shorten firebase ids)
    Logger.repository.info("Created room with ID: ${response.id}");
    _updateField(id!, "id", id);

    return response;
  }

  Future<RoomListResponse> getRooms() async {
    final List<Json> roomList = [];

    try {
      final rooms = await _roomsDb.get();
      for (DocData doc in rooms.docs) {
        roomList.add(doc.data());
      }

      return (rooms: roomList, error: null);
    } catch (error) {
      final result = (
        rooms: List<Json>.empty(),
        error: error.toString(),
      );

      return Future.value(result);
    }
  }

  Future<RoomRepoResponse> updateConfig(String id, Json config) async =>
      _updateField(id, ROOM_CONFIG, config);

  Future<RoomRepoResponse> updatePlayers(
    String id,
    List<Json> playerList,
  ) async =>
      _updateField(id, PLAYER_LIST, playerList);

  Future<RoomRepoResponse> updateReady(String id, Player player) async =>
      _updateField(id, PLAYER_LIST, player);

  Future<RoomRepoResponse> _updateField(
    String id,
    String field,
    dynamic value,
  ) async {
    // final remoteList = (getRooms() as RoomListResponse).rooms;
    // print("### remoteList: $remoteList ###");

    String? result;
    String? error;

    await _roomsDb
        .doc(id)
        .update({field: value})
        .then((value) => result = "OK")
        .catchError((error) => result = "Error: $error");

    return (id: result, error: error);
  }

  void removePlayer(String id, dynamic value) {
    print("### removing player on firestore... ###");
    print("### rooms db: $_roomsDb ###");
    print("### rooms db doc: ${_roomsDb.doc(id)} ###");

    // _roomsDb.doc(id).update({PLAYER_LIST: value});
    final foo = _roomsDb.doc(id).update({PLAYER_LIST: value});
    print("### rooms db update doc future: $foo ###");
    foo.then((value) => print("### rooms db updated ###"));
  }

  Future<String?> deleteRoom(String id) async {
    try {
      print("### removing room from repo... ###");
      await _roomsDb.doc(id).delete();
      print("### room removed ###");
    } catch (error) {
      print("### error removing room ###");
      return "Error: $error";
    }

    print("### delete room end ###");
    return null;
  }
}
