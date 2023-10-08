import 'package:things_game/translations/room_settings.i18n.dart';

class ConfigurationData {
  String name;
  int players;
  int rounds;
  int maxPoints;
  bool isPrivate;

  ConfigurationData({
    this.name = "",
    this.players = 0,
    this.rounds = 0,
    this.maxPoints = 0,
    this.isPrivate = true,
  });

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

  factory ConfigurationData.fromJson(Map<String, dynamic> json) {
    return ConfigurationData();
  }

  String toJson() {
    return "{ \"name\": $name, \"players\": $players, \"rounds\": $rounds, "
        "\"maxPoints\": $maxPoints, \"isPrivate\": $isPrivate, }";
  }

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

extension ValidateConfig on ConfigurationData {
  String? validate(int? value, [isNumPlayers = false]) {
    if (value == null) {
      return 'This field is mandatory'.i18n;
    }

    if (isNumPlayers && value < 3) {
      return 'The number of players must be greater than 2'.i18n;
    }

    if (value < 0) {
      return 'The value must be greater than 0'.i18n;
    }

    return null;
  }
}