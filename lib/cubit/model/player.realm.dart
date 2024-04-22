// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Player extends _Player with RealmEntity, RealmObjectBase, RealmObject {
  Player(
    String name,
    bool isReady,
  ) {
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
          fromEJson(isReady),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Player._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Player, 'Player', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('isReady', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
