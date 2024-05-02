import 'dart:convert';

import 'package:things_game/model/realm_models.dart';
import 'package:things_game/translations/room_settings.i18n.dart';

// TODO: maybe replace this with its DB model?
class ConfigurationData {
  late ConfigurationDataDB _db;

  ConfigurationData({
    String name = "",
    int players = 0,
    int rounds = 0,
    int maxPoints = 0,
    bool isPrivate = true,
  }) {
    // TODO: get data from DB
    _db = ConfigurationDataDB();

    this.name = name;
    this.players = players;
    this.rounds = rounds;
    this.maxPoints = maxPoints;
    this.isPrivate = isPrivate;
  }

  factory ConfigurationData.empty() {
    return ConfigurationData(
      name: "",
      players: 0,
      rounds: 0,
      maxPoints: 0,
      isPrivate: true,
    );
  }

  factory ConfigurationData.fromDB(ConfigurationDataDB db) {
    return ConfigurationData(
      name: db.name,
      players: db.players,
      rounds: db.rounds,
      maxPoints: db.maxPoints,
      isPrivate: db.isPrivate,
    );
  }

  ConfigurationData copyWith({
    String? name,
    int? players,
    int? rounds,
    int? maxPoints,
    bool? isPrivate,
  }) {
    return ConfigurationData(
      name: name ?? this.name,
      players: players ?? this.players,
      rounds: rounds ?? this.rounds,
      maxPoints: maxPoints ?? this.maxPoints,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "players": players,
      "rounds": rounds,
      "maxPoints": maxPoints,
      "isPrivate": isPrivate,
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  bool operator ==(Object other) {
    if (other is! ConfigurationData) return false;
    return name == other.name &&
        players == other.players &&
        rounds == other.rounds &&
        maxPoints == other.maxPoints &&
        isPrivate == other.isPrivate;
  }

  @override
  int get hashCode => name.hashCode;
}

extension ConfigurationDataUtilsDB on ConfigurationData {
  ConfigurationDataDB get db => _db;

  // Get attributes
  String get name => _db.name;
  int get players => _db.players;
  int get rounds => _db.rounds;
  int get maxPoints => _db.maxPoints;
  bool get isPrivate => _db.isPrivate;

  // Set attributes
  set name(String value) => _db.name = value;
  set players(int value) => _db.players = value;
  set rounds(int value) => _db.rounds = value;
  set maxPoints(int value) => _db.maxPoints = value;
  set isPrivate(bool value) => _db.isPrivate = value;

  // set name(String value) => _db.realm.write(() => _db.name = value);
  // set players(int value) => _db.realm.write(() => _db.players = value);
  // set rounds(int value) => _db.realm.write(() => _db.rounds = value);
  // set maxPoints(int value) => _db.realm.write(() => _db.maxPoints = value);
  // set isPrivate(bool value) => _db.realm.write(() => _db.isPrivate = value);
}

extension ValidateConfig on ConfigurationData {
  String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is mandatory'.i18n;
    }

    return null;
  }

  String? validateInt(int? value, [isNumPlayers = false]) {
    if (value == null) {
      return 'This field is mandatory'.i18n;
    }

    if (isNumPlayers && value < 3) {
      return 'The number of players must be greater than 2'.i18n;
    }

    if (value <= 0) {
      return 'The value must be greater than 0'.i18n;
    }

    return null;
  }
}
