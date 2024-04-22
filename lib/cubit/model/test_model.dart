import 'package:realm/realm.dart';

part 'test_model.realm.dart';

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
  late bool isReady;
}

// TODO: revert nullable on 'late _ConfigurationData? config'.
// FIXME: Realm object references must be nullable.
@RealmModel()
class _GameRoom {
  late String id;
  late _ConfigurationData? config;
  late List<_Player> playerList;
}

@RealmModel(ObjectType.embeddedObject)
class _Assignment {
  late String playerName;

  @Ignored()
  late Map<String, dynamic> playerAssignment;
}

@RealmModel(ObjectType.embeddedObject)
class _QuestionBoard {
  late String question;
  @Ignored()
  late Map<String, dynamic> answers;
  late List<_Assignment> assignments;
}

@RealmModel()
class _GameBoard {
  late String id;
  late List<_QuestionBoard> questionBoard;
}