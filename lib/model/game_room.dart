import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';

import 'package:things_game/model/configuration_data.dart';
import 'package:things_game/model/player.dart';
import 'package:things_game/model/realm_models.dart';

// class GameRoom with Streamable<GameRoom> {
class GameRoom {
  late GameRoomDB _db;

  GameRoom({
    required ConfigurationData config,
    required List<Player> playerList,
  }) {
    // TODO: get data from DB
    _db = GameRoomDB(ObjectId());

    this.config = config;
    this.playerList = playerList;
  }

  GameRoom copyWith({
    ConfigurationData? config,
    List<Player>? playerList,
  }) {
    return GameRoom(
      config: config ?? this.config,
      playerList: playerList ?? this.playerList,
    );
  }

  factory GameRoom.empty() {
    return GameRoom(
      config: ConfigurationData.empty(),
      playerList: [],
    );
  }

  factory GameRoom.sample() {
    return GameRoom(
      //id: "Id#${Random().nextInt(999)}",
      config: ConfigurationData(
        name: "Game#${Random().nextInt(999)}",
        players: Random().nextInt(10),
        rounds: Random().nextInt(10),
        maxPoints: Random().nextInt(70),
        isPrivate: Random().nextBool(),
      ),
      playerList: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "config": config.toJson(),
      "playerList": List<dynamic>.from(playerList.map((x) => x)),
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) {
    if (other is! GameRoom) return false;
    return config == other.config && listEquals(playerList, other.playerList);
  }

  @override
  int get hashCode => id.hashCode;
}

extension GameRoomUtilsDB on GameRoom {
  GameRoomDB get db => _db;

  Stream<RealmObjectChanges<GameRoomDB>> get changes => _db.changes;

  // Get attributes
  String get id => _db.id.hexString;

  ConfigurationData get config =>
      ConfigurationData.fromDB(_db.configData ?? ConfigurationDataDB());

  List<Player> get playerList =>
      _db.playerList.toList().map((e) => Player.fromDB(e)).toList();

  // Set attributes
  set config(ConfigurationData value) =>
      // _db.realm.write(() => _db.configData = value.db);
      _db.configData = value.db;

  set playerList(List<Player> value) {
    _db.playerList.clear();
    _db.playerList.addAll(value.map((e) => e.db));
  }
}
