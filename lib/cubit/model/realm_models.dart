import 'package:realm/realm.dart';

import '../../streams/streamable_mixin.dart';

part 'realm_models.realm.dart';

// TODO: Add named parameters
@RealmModel(ObjectType.embeddedObject)
class _ConfigurationData {
  late String name;
  late int players;
  late int rounds;
  late int maxPoints;
  late bool isPrivate;
}

@RealmModel(ObjectType.embeddedObject)
class _Player {
  late String name;
  // TODO: add default value to false
  late bool isReady;
}

// TODO: revert nullable on 'late _ConfigurationData? config'.
// FIXME: Realm object references must be nullable.
@RealmModel()
class _GameRoom with Streamable<GameRoom> {
  late String id;
  late _ConfigurationData? config;
  late List<_Player> playerList;
}

@RealmModel(ObjectType.embeddedObject)
class _Assignment {
  late String playerName;
  late Map<String, String> playerAssignment;
}

@RealmModel(ObjectType.embeddedObject)
class _QuestionBoard {
  late String question;
  late Map<String, String> answers;
  late List<_Assignment> assignments;
}

@RealmModel()
class _GameBoard with Streamable<GameBoard> {
  late String id;
  late List<_QuestionBoard> questionBoard;
}