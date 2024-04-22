// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Assignment extends _Assignment
    with RealmEntity, RealmObjectBase, RealmObject {
  Assignment(
    String playerName,
  ) {
    RealmObjectBase.set(this, 'playerName', playerName);
  }

  Assignment._();

  @override
  String get playerName =>
      RealmObjectBase.get<String>(this, 'playerName') as String;
  @override
  set playerName(String value) =>
      RealmObjectBase.set(this, 'playerName', value);

  @override
  Stream<RealmObjectChanges<Assignment>> get changes =>
      RealmObjectBase.getChanges<Assignment>(this);

  @override
  Assignment freeze() => RealmObjectBase.freezeObject<Assignment>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'playerName': playerName.toEJson(),
    };
  }

  static EJsonValue _toEJson(Assignment value) => value.toEJson();
  static Assignment _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'playerName': EJsonValue playerName,
      } =>
        Assignment(
          fromEJson(playerName),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Assignment._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Assignment, 'Assignment', [
      SchemaProperty('playerName', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
