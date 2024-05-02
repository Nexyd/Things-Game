import 'package:realm/realm.dart';

import 'package:things_game/model/player.dart';
import 'package:things_game/model/realm_models.dart';
import 'package:things_game/support/constants.dart';
import 'package:things_game/support/mongo_manager.dart';

typedef Json = Map<String, dynamic>;

class RoomRepository {
  late Realm realm;

  static const String queryAllName = "getAllItemsSubscription";
  //late final CollectionReference<Map<String, dynamic>> _roomsDb;

  RoomRepository() {
    // TODO: create collection if it doesn't exist.
    //_roomsDb = FirebaseFirestore.instance.collection("rooms");

    realm = Realm(MongoManager.I.roomConfig);
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<GameRoomDB>());
    });
  }

  void query() {
    // final result = realm.query<GameRoomDB>('authorName BEGINSWITH \$0', ["Use"]);
    // final result = realm.query<GameRoomDB>('config != null');
    final result = realm.all<GameRoomDB>();
    // realm.subscriptions.findByName("getAllItemsSubscription");

    print("### result: ${result.length} ###");
  }

  Future<String> createRoom(Json roomJson) async {
    String result = "";
    // await _roomsDb
    //     .add(roomJson)
    //     .then((value) => result = value.id)
    //     .catchError((error) => result = "Error: $error");

    _updateField(result, "id", result);
    return result;
  }

  Future<List<Json>> getRooms() async {
    final List<Json> roomList = [];
    // await _roomsDb.get().then((event) {
    //   for (var doc in event.docs) {
    //     roomList.add(doc.data());
    //   }
    // }).catchError((error) {
    //   roomList.add({"error": error});
    // });

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
    // await _roomsDb
    //     .doc(id)
    //     .update({field: value})
    //     .then((value) => result = "OK")
    //     .catchError((error) => result = "Error: $error");

    return result;
  }

  Future<String?> deleteRoom(String id) async {
    try {
      //await _roomsDb.doc(id).delete();
    } catch (error) {
      return "Error: $error";
    }

    return null;
  }
}
