import 'package:realm/realm.dart';

import '../../streams/streamable_mixin.dart';

part 'realm_models.realm.dart';

@RealmModel(ObjectType.embeddedObject)
class _ConfigurationDataDB {
  late String name = "";
  late int players = 0;
  late int rounds = 0;
  late int maxPoints = 0;
  late bool isPrivate = true;
}

@RealmModel(ObjectType.embeddedObject)
class _PlayerDB {
  late String name = "";
  late bool isReady = false;
}

// TODO: revert nullable on 'late _ConfigurationData? config'.
// although it doesn't seem possible...
// 'Realm object references must be nullable.'
// https://www.mongodb.com/docs/atlas/device-sdks/sdk/flutter/realm-database/model-data/relationships/#std-label-flutter-client-relationships
@RealmModel()
class _GameRoomDB with Streamable<GameRoomDB> {
  late String id = "";
  late _ConfigurationDataDB? configData;
  late List<_PlayerDB> playerList = [];

  // ConfigurationData get config => configData == null ? configData : ConfigurationData();
  ConfigurationDataDB get config => ConfigurationDataDB();
}

@RealmModel(ObjectType.embeddedObject)
class _AssignmentDB {
  late String playerName = "";
  late Map<String, String> playerAssignment = {};
}

@RealmModel(ObjectType.embeddedObject)
class _QuestionBoardDB {
  late String question = "";
  late Map<String, String> answers = {};
  late List<_AssignmentDB> assignments = [];
}

@RealmModel()
class _GameBoardDB with Streamable<GameBoardDB> {
  late String id = "";
  late List<_QuestionBoardDB> questionBoard = [];
}