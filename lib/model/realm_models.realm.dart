// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ConfigurationDataDB extends _ConfigurationDataDB
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  ConfigurationDataDB({
    String name = "",
    int players = 0,
    int rounds = 0,
    int maxPoints = 0,
    bool isPrivate = true,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<ConfigurationDataDB>({
        'name': "",
        'players': 0,
        'rounds': 0,
        'maxPoints': 0,
        'isPrivate': true,
      });
    }
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'players', players);
    RealmObjectBase.set(this, 'rounds', rounds);
    RealmObjectBase.set(this, 'maxPoints', maxPoints);
    RealmObjectBase.set(this, 'isPrivate', isPrivate);
  }

  ConfigurationDataDB._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get players => RealmObjectBase.get<int>(this, 'players') as int;
  @override
  set players(int value) => RealmObjectBase.set(this, 'players', value);

  @override
  int get rounds => RealmObjectBase.get<int>(this, 'rounds') as int;
  @override
  set rounds(int value) => RealmObjectBase.set(this, 'rounds', value);

  @override
  int get maxPoints => RealmObjectBase.get<int>(this, 'maxPoints') as int;
  @override
  set maxPoints(int value) => RealmObjectBase.set(this, 'maxPoints', value);

  @override
  bool get isPrivate => RealmObjectBase.get<bool>(this, 'isPrivate') as bool;
  @override
  set isPrivate(bool value) => RealmObjectBase.set(this, 'isPrivate', value);

  @override
  Stream<RealmObjectChanges<ConfigurationDataDB>> get changes =>
      RealmObjectBase.getChanges<ConfigurationDataDB>(this);

  @override
  ConfigurationDataDB freeze() =>
      RealmObjectBase.freezeObject<ConfigurationDataDB>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'name': name.toEJson(),
      'players': players.toEJson(),
      'rounds': rounds.toEJson(),
      'maxPoints': maxPoints.toEJson(),
      'isPrivate': isPrivate.toEJson(),
    };
  }

  static EJsonValue _toEJson(ConfigurationDataDB value) => value.toEJson();
  static ConfigurationDataDB _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'name': EJsonValue name,
        'players': EJsonValue players,
        'rounds': EJsonValue rounds,
        'maxPoints': EJsonValue maxPoints,
        'isPrivate': EJsonValue isPrivate,
      } =>
        ConfigurationDataDB(
          name: fromEJson(name),
          players: fromEJson(players),
          rounds: fromEJson(rounds),
          maxPoints: fromEJson(maxPoints),
          isPrivate: fromEJson(isPrivate),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ConfigurationDataDB._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.embeddedObject, ConfigurationDataDB, 'ConfigurationDataDB', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('players', RealmPropertyType.int),
      SchemaProperty('rounds', RealmPropertyType.int),
      SchemaProperty('maxPoints', RealmPropertyType.int),
      SchemaProperty('isPrivate', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class PlayerDB extends _PlayerDB
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  PlayerDB({
    String name = "",
    bool isReady = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<PlayerDB>({
        'name': "",
        'isReady': false,
      });
    }
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'isReady', isReady);
  }

  PlayerDB._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get isReady => RealmObjectBase.get<bool>(this, 'isReady') as bool;
  @override
  set isReady(bool value) => RealmObjectBase.set(this, 'isReady', value);

  @override
  Stream<RealmObjectChanges<PlayerDB>> get changes =>
      RealmObjectBase.getChanges<PlayerDB>(this);

  @override
  PlayerDB freeze() => RealmObjectBase.freezeObject<PlayerDB>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'name': name.toEJson(),
      'isReady': isReady.toEJson(),
    };
  }

  static EJsonValue _toEJson(PlayerDB value) => value.toEJson();
  static PlayerDB _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'name': EJsonValue name,
        'isReady': EJsonValue isReady,
      } =>
        PlayerDB(
          name: fromEJson(name),
          isReady: fromEJson(isReady),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PlayerDB._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.embeddedObject, PlayerDB, 'PlayerDB', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('isReady', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class GameRoomDB extends _GameRoomDB
    with RealmEntity, RealmObjectBase, RealmObject {
  GameRoomDB(
    ObjectId id, {
    ConfigurationDataDB? configData,
    Iterable<PlayerDB> playerList = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'configData', configData);
    RealmObjectBase.set<RealmList<PlayerDB>>(
        this, 'playerList', RealmList<PlayerDB>(playerList));
  }

  GameRoomDB._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  ConfigurationDataDB? get configData =>
      RealmObjectBase.get<ConfigurationDataDB>(this, 'configData')
          as ConfigurationDataDB?;
  @override
  set configData(covariant ConfigurationDataDB? value) =>
      RealmObjectBase.set(this, 'configData', value);

  @override
  RealmList<PlayerDB> get playerList =>
      RealmObjectBase.get<PlayerDB>(this, 'playerList') as RealmList<PlayerDB>;
  @override
  set playerList(covariant RealmList<PlayerDB> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<GameRoomDB>> get changes =>
      RealmObjectBase.getChanges<GameRoomDB>(this);

  @override
  GameRoomDB freeze() => RealmObjectBase.freezeObject<GameRoomDB>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'configData': configData.toEJson(),
      'playerList': playerList.toEJson(),
    };
  }

  static EJsonValue _toEJson(GameRoomDB value) => value.toEJson();
  static GameRoomDB _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'configData': EJsonValue configData,
        'playerList': EJsonValue playerList,
      } =>
        GameRoomDB(
          fromEJson(id),
          configData: fromEJson(configData),
          playerList: fromEJson(playerList),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(GameRoomDB._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, GameRoomDB, 'GameRoomDB', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('configData', RealmPropertyType.object,
          optional: true, linkTarget: 'ConfigurationDataDB'),
      SchemaProperty('playerList', RealmPropertyType.object,
          linkTarget: 'PlayerDB', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AssignmentDB extends _AssignmentDB
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  AssignmentDB({
    String playerName = "",
    Map<String, String> playerAssignment = const {},
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<AssignmentDB>({
        'playerName': "",
      });
    }
    RealmObjectBase.set(this, 'playerName', playerName);
    RealmObjectBase.set<RealmMap<String>>(
        this, 'playerAssignment', RealmMap<String>(playerAssignment));
  }

  AssignmentDB._();

  @override
  String get playerName =>
      RealmObjectBase.get<String>(this, 'playerName') as String;
  @override
  set playerName(String value) =>
      RealmObjectBase.set(this, 'playerName', value);

  @override
  RealmMap<String> get playerAssignment =>
      RealmObjectBase.get<String>(this, 'playerAssignment') as RealmMap<String>;
  @override
  set playerAssignment(covariant RealmMap<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<AssignmentDB>> get changes =>
      RealmObjectBase.getChanges<AssignmentDB>(this);

  @override
  AssignmentDB freeze() => RealmObjectBase.freezeObject<AssignmentDB>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'playerName': playerName.toEJson(),
      'playerAssignment': playerAssignment.toEJson(),
    };
  }

  static EJsonValue _toEJson(AssignmentDB value) => value.toEJson();
  static AssignmentDB _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'playerName': EJsonValue playerName,
        'playerAssignment': EJsonValue playerAssignment,
      } =>
        AssignmentDB(
          playerName: fromEJson(playerName),
          playerAssignment: fromEJson(playerAssignment),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AssignmentDB._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.embeddedObject, AssignmentDB, 'AssignmentDB', [
      SchemaProperty('playerName', RealmPropertyType.string),
      SchemaProperty('playerAssignment', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class QuestionBoardDB extends _QuestionBoardDB
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  QuestionBoardDB({
    String question = "",
    Map<String, String> answers = const {},
    Iterable<AssignmentDB> assignments = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<QuestionBoardDB>({
        'question': "",
      });
    }
    RealmObjectBase.set(this, 'question', question);
    RealmObjectBase.set<RealmMap<String>>(
        this, 'answers', RealmMap<String>(answers));
    RealmObjectBase.set<RealmList<AssignmentDB>>(
        this, 'assignments', RealmList<AssignmentDB>(assignments));
  }

  QuestionBoardDB._();

  @override
  String get question =>
      RealmObjectBase.get<String>(this, 'question') as String;
  @override
  set question(String value) => RealmObjectBase.set(this, 'question', value);

  @override
  RealmMap<String> get answers =>
      RealmObjectBase.get<String>(this, 'answers') as RealmMap<String>;
  @override
  set answers(covariant RealmMap<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<AssignmentDB> get assignments =>
      RealmObjectBase.get<AssignmentDB>(this, 'assignments')
          as RealmList<AssignmentDB>;
  @override
  set assignments(covariant RealmList<AssignmentDB> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<QuestionBoardDB>> get changes =>
      RealmObjectBase.getChanges<QuestionBoardDB>(this);

  @override
  QuestionBoardDB freeze() =>
      RealmObjectBase.freezeObject<QuestionBoardDB>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'question': question.toEJson(),
      'answers': answers.toEJson(),
      'assignments': assignments.toEJson(),
    };
  }

  static EJsonValue _toEJson(QuestionBoardDB value) => value.toEJson();
  static QuestionBoardDB _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'question': EJsonValue question,
        'answers': EJsonValue answers,
        'assignments': EJsonValue assignments,
      } =>
        QuestionBoardDB(
          question: fromEJson(question),
          answers: fromEJson(answers),
          assignments: fromEJson(assignments),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(QuestionBoardDB._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.embeddedObject, QuestionBoardDB, 'QuestionBoardDB', [
      SchemaProperty('question', RealmPropertyType.string),
      SchemaProperty('answers', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
      SchemaProperty('assignments', RealmPropertyType.object,
          linkTarget: 'AssignmentDB', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class GameBoardDB extends _GameBoardDB
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  GameBoardDB(
    ObjectId id, {
    String roomId = "",
    Iterable<QuestionBoardDB> questionBoard = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<GameBoardDB>({
        'roomId': "",
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'roomId', roomId);
    RealmObjectBase.set<RealmList<QuestionBoardDB>>(
        this, 'questionBoard', RealmList<QuestionBoardDB>(questionBoard));
  }

  GameBoardDB._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get roomId => RealmObjectBase.get<String>(this, 'roomId') as String;
  @override
  set roomId(String value) => RealmObjectBase.set(this, 'roomId', value);

  @override
  RealmList<QuestionBoardDB> get questionBoard =>
      RealmObjectBase.get<QuestionBoardDB>(this, 'questionBoard')
          as RealmList<QuestionBoardDB>;
  @override
  set questionBoard(covariant RealmList<QuestionBoardDB> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<GameBoardDB>> get changes =>
      RealmObjectBase.getChanges<GameBoardDB>(this);

  @override
  GameBoardDB freeze() => RealmObjectBase.freezeObject<GameBoardDB>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'roomId': roomId.toEJson(),
      'questionBoard': questionBoard.toEJson(),
    };
  }

  static EJsonValue _toEJson(GameBoardDB value) => value.toEJson();
  static GameBoardDB _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'roomId': EJsonValue roomId,
        'questionBoard': EJsonValue questionBoard,
      } =>
        GameBoardDB(
          fromEJson(id),
          roomId: fromEJson(roomId),
          questionBoard: fromEJson(questionBoard),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(GameBoardDB._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, GameBoardDB, 'GameBoardDB', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('roomId', RealmPropertyType.string),
      SchemaProperty('questionBoard', RealmPropertyType.object,
          linkTarget: 'QuestionBoardDB',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
