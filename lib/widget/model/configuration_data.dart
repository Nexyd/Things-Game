import 'dart:convert';

import 'package:things_game/translations/room_settings.i18n.dart';

import 'package:things_game/cubit/model/realm_models.dart';

extension ConfigurationDataUtils on ConfigurationData {
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

  static ConfigurationData empty() {
    return ConfigurationData(
      name: "",
      players: 0,
      rounds: 0,
      maxPoints: 0,
      isPrivate: true,
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

  bool compareTo(Object other) {
    if (other is! ConfigurationData) return false;
    return name == other.name &&
        players == other.players &&
        rounds == other.rounds &&
        maxPoints == other.maxPoints &&
        isPrivate == other.isPrivate;
  }
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
