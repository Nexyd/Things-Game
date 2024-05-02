import 'package:realm/realm.dart';
import 'package:things_game/model/game_room.dart';

import 'package:things_game/model/player.dart';
import 'package:things_game/model/realm_models.dart';
import 'package:things_game/support/constants.dart';
import 'package:things_game/support/mongo_manager.dart';

typedef Json = Map<String, dynamic>;
const String QUERY_ALL_NAME = "getAllItemsSubscription";

class RoomRepository {
  late Realm _realm;
  //late final CollectionReference<Map<String, dynamic>> _roomsDb;

  RoomRepository() {
    // TODO: create collection if it doesn't exist.
    //_roomsDb = FirebaseFirestore.instance.collection("rooms");

    _initRealm();
  }

  Future<void> _initRealm() async {
    print("### initializing realm... ###");
    _realm = Realm(MongoManager.I.roomConfig);

    print("### updating subscriptions... ###");
    _realm.subscriptions.update((mutableSubscriptions) {
      // mutableSubscriptions.add(_realm.all<GameRoomDB>());
      mutableSubscriptions.add(_realm.all<GameRoomDB>(), name: QUERY_ALL_NAME);
      // mutableSubscriptions.add(
      //   _realm.query<GameRoomDB>(r'name == $0 AND age > $1', ['Clifford', 5]),
      // );
    });

    print("### waiting for synchronization... ###");
    await _realm.subscriptions.waitForSynchronization();

    print("### realm synchronized ###");
  }

  void testQuery() {
    print("#########");
    print("#########");
    print("### ----------------- TEST QUERY ----------------- ###");
    final result = _realm.all<GameRoomDB>();
    print("### result: ${result.length} ###");

    if (result.isNotEmpty) {
      final foo = result.first;
      print("#########");
      print("### result id hexString: ${foo.id.hexString} ###");
      print("### result id: ${foo.id} ###");
      print("### result playerList: ${foo.playerList} ###");
      print("### result config name: ${foo.configData?.name} ###");
      print("### result config numPlayers: ${foo.configData?.players} ###");
      print("### result config rounds: ${foo.configData?.rounds} ###");
      print("### result config maxPoints: ${foo.configData?.maxPoints} ###");
      print("### result config isPrivate: ${foo.configData?.isPrivate} ###");
      print("#########");
    }

    print("### ----------------- TEST QUERY ----------------- ###");
    print("#########");
    print("#########");
  }

  void testCreateRoom() async {
    print("#########");
    print("#########");
    print("### ----------------- TEST CREATE ROOM ----------------- ###");
    print("### creating config... ###");
    final config = ConfigurationDataDB(
        name: "Foo", players: 4, rounds: 3, maxPoints: 72, isPrivate: true);
    print("### config: ${config.toEJson()} ###");

    print("### creating room... ###");
    final room = GameRoomDB(ObjectId(), configData: config, playerList: []);
    print("### room: ${room.toEJson()} ###");

    print("### saving room to db... ###");
    final result = _realm.write<GameRoomDB>(
      () => _realm.add<GameRoomDB>(room),
    );

    print("### saved to db ###");
    print("### result: ${result.toEJson()} ###");
    print("### ----------------- TEST CREATE ROOM ----------------- ###");
    print("#########");
    print("#########");

    testQuery();
  }

  // Future<String> createRoom(Json roomJson) async {
  Future<String> createRoom(GameRoom room) async {
    String result = "";
    // await _roomsDb
    //     .add(roomJson)
    //     .then((value) => result = value.id)
    //     .catchError((error) => result = "Error: $error");

    print("### creating room: ${room.toJson()} ###");
    _realm.write<GameRoomDB>(() => _realm.add<GameRoomDB>(room.db));

    //_updateField(result, "id", result);
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
