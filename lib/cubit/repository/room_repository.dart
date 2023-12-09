import 'package:cloud_firestore/cloud_firestore.dart';

import '../../support/constants.dart';

typedef Json = Map<String, dynamic>;

class RoomRepository {
  final roomsDb = FirebaseFirestore.instance.collection("rooms");

  Future<String> createRoom(Json roomJson) async {
    String result = "";
    await roomsDb
        .add(roomJson)
        .then((value) => result = value.id)
        .catchError((error) => result = "Error: $error");

    return result;
  }

  Future<List<Json>> getRooms() async {
    final List<Json> roomList = [];
    await roomsDb.get().then((event) {
      for (var doc in event.docs) {
        roomList.add(doc.data());
      }
    }).catchError((error) {
      roomList.add({"error": error});
    });

    return roomList;
  }

  Future<String> updatePlayers(String id, List<String> playerList) async {
    print("### room repository update players ###");
    String result = "";
    await roomsDb
        .doc(id)
        .update({PLAYER_LIST: playerList})
        .then((value) => result = "OK")
        .catchError((error) => result = "Error: $error");

    return result;
  }

  Future<String?> deleteRoom(String id) async {
    try {
      await roomsDb.doc(id).delete();
    } catch (error) {
      return "Error: $error";
    }

    return null;
  }
}
