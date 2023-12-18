import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import '../../support/constants.dart';
import '../model/game_room.dart';

typedef Json = Map<String, dynamic>;

class RoomRepository {
  late final CollectionReference<Map<String, dynamic>> _roomsDb;

  RoomRepository() {
    // TODO: create collection if it doesn't exist.
    _roomsDb = FirebaseFirestore.instance.collection("rooms");
  }

  Future<String> createRoom(Json roomJson) async {
    String result = "";
    await _roomsDb
        .add(roomJson)
        .then((value) => result = value.id)
        .catchError((error) => result = "Error: $error");

    _updateField(result, "id", result);
    return result;
  }

  Future<List<Json>> getRooms() async {
    final List<Json> roomList = [];
    await _roomsDb.get().then((event) {
      for (var doc in event.docs) {
        roomList.add(doc.data());
      }
    }).catchError((error) {
      roomList.add({"error": error});
    });

    return roomList;
  }

  Future<String> updateConfig(String id, Json config) async =>
      _updateField(id, ROOM_CONFIG, config);

  Future<String> updatePlayers(String id, List<Player> playerList) async =>
      _updateField(id, PLAYER_LIST, playerList);

  Future<String> updateReady(String id, Player player) async =>
      _updateField(id, PLAYER_LIST, player);

  Future<String> _updateField(String id, String field, dynamic value) async {
    String result = "";
    await _roomsDb
        .doc(id)
        .update({field: value})
        .then((value) => result = "OK")
        .catchError((error) => result = "Error: $error");

    return result;
  }

  Future<String?> deleteRoom(String id) async {
    try {
      await _roomsDb.doc(id).delete();
    } catch (error) {
      return "Error: $error";
    }

    return null;
  }
}
