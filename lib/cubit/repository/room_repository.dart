import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/widget/model/configuration_data.dart';

import '../../support/constants.dart';
import '../model/game_room.dart';

typedef Json = Map<String, dynamic>;
typedef DocData = QueryDocumentSnapshot<Map<String, dynamic>>;
typedef RoomsResponse = ({List<Json> rooms, String? error});

class RoomRepository {
  late final CollectionReference<Map<String, dynamic>> _roomsDb;

  RoomRepository() {
    // TODO: create collection if it doesn't exist?.
    _roomsDb = FirebaseFirestore.instance.collection("rooms");
  }

  // TODO: Change 'String result' to Records with success and error.
  Future<String> createRoom(Json roomJson) async {
    String result = "";
    await _roomsDb
        .add(roomJson)
        .then((value) => result = value.id)
        .catchError((error) => result = "Error: $error");

    _updateField(result, "id", result);
    return result;
  }

  // Future<List<Json>> getRooms() async {
  //   final List<Json> roomList = [];
  //   await _roomsDb.get().then((event) {
  //     for (DocData doc in event.docs) {
  //       roomList.add(doc.data());
  //     }
  //   }).catchError((error) {
  //     roomList.add({"error": error});
  //   });
  //
  //   return roomList;
  // }
  
  Future<RoomsResponse> getRooms() async {
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

  Future<String> updateConfig(String id, Json config) async =>
      _updateField(id, ROOM_CONFIG, config);

  Future<String> updatePlayers(String id, List<Player> playerList) async =>
      _updateField(id, PLAYER_LIST, playerList);

  Future<String> updateReady(String id, Player player) async =>
      _updateField(id, PLAYER_LIST, player);

  // TODO: Change 'String result' to Records with success and error.
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
