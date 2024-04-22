// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_data.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ConfigurationData extends _ConfigurationData
    with RealmEntity, RealmObjectBase, RealmObject {
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
        ObjectType.realmObject, ConfigurationData, 'ConfigurationData', [
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
