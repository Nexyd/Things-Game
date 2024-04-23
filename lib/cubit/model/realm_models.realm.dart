// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ConfigurationData extends _ConfigurationData
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ConfigurationData(
    String name,
    int players,
    int rounds,
    int maxPoints,
    bool isPrivate,
  ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'players', players);
    RealmObjectBase.set(this, 'rounds', rounds);
    RealmObjectBase.set(this, 'maxPoints', maxPoints);
    RealmObjectBase.set(this, 'isPrivate', isPrivate);
  }

  ConfigurationData._();

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
  Stream<RealmObjectChanges<ConfigurationData>> get changes =>
      RealmObjectBase.getChanges<ConfigurationData>(this);

  @override
  ConfigurationData freeze() =>
      RealmObjectBase.freezeObject<ConfigurationData>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'name': name.toEJson(),
      'players': players.toEJson(),
      'rounds': rounds.toEJson(),
      'maxPoints': maxPoints.toEJson(),
      'isPrivate': isPrivate.toEJson(),
    };
  }

  static EJsonValue _toEJson(ConfigurationData value) => value.toEJson();
  static ConfigurationData _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'name': EJsonValue name,
        'players': EJsonValue players,
        'rounds': EJsonValue rounds,
        'maxPoints': EJsonValue maxPoints,
        'isPrivate': EJsonValue isPrivate,
      } =>
        ConfigurationData(
          fromEJson(name),
          fromEJson(players),
          fromEJson(rounds),
          fromEJson(maxPoints),
          fromEJson(isPrivate),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ConfigurationData._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.embeddedObject, ConfigurationData, 'ConfigurationData', [
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

class Player extends _Player with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  Player(
    String name, {
    bool isReady = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Player>({
        'isReady': false,
      });
    }
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'isReady', isReady);
  }

  Player._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get isReady => RealmObjectBase.get<bool>(this, 'isReady') as bool;
  @override
  set isReady(bool value) => RealmObjectBase.set(this, 'isReady', value);

  @override
  Stream<RealmObjectChanges<Player>> get changes =>
      RealmObjectBase.getChanges<Player>(this);

  @override
  Player freeze() => RealmObjectBase.freezeObject<Player>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'name': name.toEJson(),
      'isReady': isReady.toEJson(),
    };
  }

  static EJsonValue _toEJson(Player value) => value.toEJson();
  static Player _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'name': EJsonValue name,
        'isReady': EJsonValue isReady,
      } =>
        Player(
          fromEJson(name),
          isReady: fromEJson(isReady),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Player._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.embeddedObject, Player, 'Player', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('isReady', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class GameRoom extends _GameRoom
    with RealmEntity, RealmObjectBase, RealmObject {
  GameRoom(
    String id, {
    ConfigurationData? config,
    Iterable<Player> playerList = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'config', config);
    RealmObjectBase.set<RealmList<Player>>(
        this, 'playerList', RealmList<Player>(playerList));
  }

  GameRoom._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  ConfigurationData? get config =>
      RealmObjectBase.get<ConfigurationData>(this, 'config')
          as ConfigurationData?;
  @override
  set config(covariant ConfigurationData? value) =>
      RealmObjectBase.set(this, 'config', value);

  @override
  RealmList<Player> get playerList =>
      RealmObjectBase.get<Player>(this, 'playerList') as RealmList<Player>;
  @override
  set playerList(covariant RealmList<Player> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<GameRoom>> get changes =>
      RealmObjectBase.getChanges<GameRoom>(this);

  @override
  GameRoom freeze() => RealmObjectBase.freezeObject<GameRoom>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'config': config.toEJson(),
      'playerList': playerList.toEJson(),
    };
  }

  static EJsonValue _toEJson(GameRoom value) => value.toEJson();
  static GameRoom _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'config': EJsonValue config,
        'playerList': EJsonValue playerList,
      } =>
        GameRoom(
          fromEJson(id),
          config: fromEJson(config),
          playerList: fromEJson(playerList),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(GameRoom._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, GameRoom, 'GameRoom', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('config', RealmPropertyType.object,
          optional: true, linkTarget: 'ConfigurationData'),
      SchemaProperty('playerList', RealmPropertyType.object,
          linkTarget: 'Player', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Assignment extends _Assignment
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Assignment(
    String playerName, {
    Map<String, String> playerAssignment = const {},
  }) {
    RealmObjectBase.set(this, 'playerName', playerName);
    RealmObjectBase.set<RealmMap<String>>(
        this, 'playerAssignment', RealmMap<String>(playerAssignment));
  }

  Assignment._();

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
  Stream<RealmObjectChanges<Assignment>> get changes =>
      RealmObjectBase.getChanges<Assignment>(this);

  @override
  Assignment freeze() => RealmObjectBase.freezeObject<Assignment>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'playerName': playerName.toEJson(),
      'playerAssignment': playerAssignment.toEJson(),
    };
  }

  static EJsonValue _toEJson(Assignment value) => value.toEJson();
  static Assignment _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'playerName': EJsonValue playerName,
        'playerAssignment': EJsonValue playerAssignment,
      } =>
        Assignment(
          fromEJson(playerName),
          playerAssignment: fromEJson(playerAssignment),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Assignment._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.embeddedObject, Assignment, 'Assignment', [
      SchemaProperty('playerName', RealmPropertyType.string),
      SchemaProperty('playerAssignment', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class QuestionBoard extends _QuestionBoard
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  QuestionBoard(
    String question, {
    Map<String, String> answers = const {},
    Iterable<Assignment> assignments = const [],
  }) {
    RealmObjectBase.set(this, 'question', question);
    RealmObjectBase.set<RealmMap<String>>(
        this, 'answers', RealmMap<String>(answers));
    RealmObjectBase.set<RealmList<Assignment>>(
        this, 'assignments', RealmList<Assignment>(assignments));
  }

  QuestionBoard._();

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
  RealmList<Assignment> get assignments =>
      RealmObjectBase.get<Assignment>(this, 'assignments')
          as RealmList<Assignment>;
  @override
  set assignments(covariant RealmList<Assignment> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<QuestionBoard>> get changes =>
      RealmObjectBase.getChanges<QuestionBoard>(this);

  @override
  QuestionBoard freeze() => RealmObjectBase.freezeObject<QuestionBoard>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'question': question.toEJson(),
      'answers': answers.toEJson(),
      'assignments': assignments.toEJson(),
    };
  }

  static EJsonValue _toEJson(QuestionBoard value) => value.toEJson();
  static QuestionBoard _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'question': EJsonValue question,
        'answers': EJsonValue answers,
        'assignments': EJsonValue assignments,
      } =>
        QuestionBoard(
          fromEJson(question),
          answers: fromEJson(answers),
          assignments: fromEJson(assignments),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(QuestionBoard._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.embeddedObject, QuestionBoard, 'QuestionBoard', [
      SchemaProperty('question', RealmPropertyType.string),
      SchemaProperty('answers', RealmPropertyType.string,
          collectionType: RealmCollectionType.map),
      SchemaProperty('assignments', RealmPropertyType.object,
          linkTarget: 'Assignment', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class GameBoard extends _GameBoard
    with RealmEntity, RealmObjectBase, RealmObject {
  GameBoard(
    String id, {
    Iterable<QuestionBoard> questionBoard = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set<RealmList<QuestionBoard>>(
        this, 'questionBoard', RealmList<QuestionBoard>(questionBoard));
  }

  GameBoard._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<QuestionBoard> get questionBoard =>
      RealmObjectBase.get<QuestionBoard>(this, 'questionBoard')
          as RealmList<QuestionBoard>;
  @override
  set questionBoard(covariant RealmList<QuestionBoard> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<GameBoard>> get changes =>
      RealmObjectBase.getChanges<GameBoard>(this);

  @override
  GameBoard freeze() => RealmObjectBase.freezeObject<GameBoard>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'questionBoard': questionBoard.toEJson(),
    };
  }

  static EJsonValue _toEJson(GameBoard value) => value.toEJson();
  static GameBoard _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'questionBoard': EJsonValue questionBoard,
      } =>
        GameBoard(
          fromEJson(id),
          questionBoard: fromEJson(questionBoard),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(GameBoard._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, GameBoard, 'GameBoard', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('questionBoard', RealmPropertyType.object,
          linkTarget: 'QuestionBoard',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
