import 'package:things_game/model/realm_models.dart';

class Player {
  late PlayerDB _db;

  Player({required String name, bool isReady = false}) {
    // TODO: get data from DB
    _db = PlayerDB();

    this.name = name;
    this.isReady = isReady;
  }

  factory Player.fromDB(PlayerDB db) {
    return Player(name: db.name, isReady: db.isReady);
  }
}

extension PlayerUtilsDB on Player {
  PlayerDB get db => _db;

  // Get attributes
  String get name => _db.name;

  bool get isReady => _db.isReady;

  // Set attributes
  set name(String value) => _db.realm.write(() => _db.name = value);

  set isReady(bool value) => _db.realm.write(() => _db.isReady = value);
}
