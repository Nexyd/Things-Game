import 'package:cloud_firestore/cloud_firestore.dart';

typedef Json = Map<String, dynamic>;

class GameRoomRepository {
  final roomsDb = FirebaseFirestore.instance.collection("rooms");

  Future<String> createRoom(Json roomJson) async {
    final result = await roomsDb.add(roomJson);
    return result.id;
  }

  Future<List<Json>> getRooms() async {
    final List<Json> roomList = [];
    await roomsDb.get().then((event) {
      for (var doc in event.docs) {
        roomList.add(doc.data());
      }
    });

    return roomList;
  }

  Future<String> updatePlayers(String id, List<String> playerList) async {
    return "";
  }

  Future<String> updateBoard(String id, String boardJson) async {
    return "";
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
