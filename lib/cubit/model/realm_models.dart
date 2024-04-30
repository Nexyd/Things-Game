import 'package:realm/realm.dart';

import '../../streams/streamable_mixin.dart';

part 'realm_models.realm.dart';

@RealmModel(ObjectType.embeddedObject)
class _ConfigurationData {
  late String name = "";
  late int players = 0;
  late int rounds = 0;
  late int maxPoints = 0;
  late bool isPrivate = true;
}

@RealmModel(ObjectType.embeddedObject)
class _Player {
  late String name = "";
  late bool isReady = false;
}

// TODO: revert nullable on 'late _ConfigurationData? config'.
// although it doesn't seem possible...
// 'Realm object references must be nullable.'
// https://www.mongodb.com/docs/atlas/device-sdks/sdk/flutter/realm-database/model-data/relationships/#std-label-flutter-client-relationships
@RealmModel()
class _GameRoom with Streamable<GameRoom> {
  late String id = "";
  late _ConfigurationData? configData;
  late List<_Player> playerList = [];

  // ConfigurationData get config => configData == null ? configData : ConfigurationData();
  ConfigurationData get config => ConfigurationData();
}

@RealmModel(ObjectType.embeddedObject)
class _Assignment {
  late String playerName = "";
  late Map<String, String> playerAssignment = {};
}

@RealmModel(ObjectType.embeddedObject)
class _QuestionBoard {
  late String question = "";
  late Map<String, String> answers = {};
  late List<_Assignment> assignments = [];
}

@RealmModel()
class _GameBoard with Streamable<GameBoard> {
  late String id = "";
  late List<_QuestionBoard> questionBoard = [];
}