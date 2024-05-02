import 'package:realm/realm.dart';
import 'package:things_game/model/realm_models.dart';

// TODO: maybe replace this with its DB model?
class Assignment {
  late AssignmentDB _db;

  Assignment({
    required String playerName,
    required Map<String, dynamic> playerAssignment,
  }) {
    // TODO: get data from DB
    _db = AssignmentDB();

    this.playerName = playerName;
    this.playerAssignment = playerAssignment;
  }

  factory Assignment.fromDB(AssignmentDB db) {
    return Assignment(
      playerName: db.playerName,
      playerAssignment: db.playerAssignment,
    );
  }

  Map<String, dynamic> toJson() {
    return {"playerName": playerName, "playerAssignment": playerAssignment};
  }
}

extension AssignmentUtilsDB on Assignment {
  AssignmentDB get db => _db;

  Stream<RealmObjectChanges<AssignmentDB>> get changes => _db.changes;

  // Get attributes
  String get playerName => _db.playerName;

  Map<String, dynamic> get playerAssignment => _db.playerAssignment;

  // Set attributes
  set playerName(String value) => _db.playerName = value;
  // set playerName(String value) => _db.realm.write(() => _db.playerName = value);

  set playerAssignment(Map<String, dynamic> value) {
    _db.playerAssignment.clear();
    // TODO: think how to do this.
    //_db.playerAssignment.addAll(value.map((e) => e.db));
  }
}
