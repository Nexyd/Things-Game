import 'package:cloud_firestore/cloud_firestore.dart';

class GameRoomRepository {
  final db = FirebaseFirestore.instance;

  Future<String> createRoom(
    Map<String, dynamic> roomJson, [
    bool isPrivate = false,
  ]) async {
    // Add a new document with a generated ID
    db.collection("rooms").add(roomJson).then(
      (doc) => print('DocumentSnapshot added with ID: ${doc.id}'),
    );

    return "";
  }

  Future<List<String>> getRooms() async {
    final List<String> roomList = [];
    await db.collection("rooms").get().then((event) {
      for (var doc in event.docs) {
        // TODO: convert to parseable string
        // {playerList: [player1, player2, player3, player4], name: Game#241, ...
        // {"playerList": ["player1", "player2", "player3", "player4"], "name": "Game#241", ...
        roomList.add(doc.data().toString());
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

  Future<String> deleteRoom(String id) async {
    return "";
  }
}
