import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/cubit/model/game_room.dart';

import '../support/logger.dart';

class FirestoreRoomController {
  late final FirebaseFirestore _firestore;
  GameRoom room;

  late final _roomRef = _firestore
      .collection('rooms')
      .doc(room.id)
      .withConverter<GameRoom>(
          fromFirestore: _convertFromRemote,
          toFirestore: _convertLocalToFirestore);

  StreamSubscription? _roomRemoteSubscription;
  StreamSubscription? _roomLocalSubscription;

  FirestoreRoomController({required this.room}) {
    _firestore = FirebaseFirestore.instance;
    _roomRemoteSubscription = _roomRef
        .snapshots()
        .listen((snapshot) => _updateLocalFromFirestore(room, snapshot));

    _roomLocalSubscription = room.localChanges
        .listen((_) => _updateFirestoreFromLocal(room, _roomRef));

    // Logger.firestore.info("Firestore initialized");
    Logger.firestore.info("### Firestore initialized");
  }

  void dispose() {
    _roomRemoteSubscription?.cancel();
    _roomLocalSubscription?.cancel();
    room = GameRoom.empty();
    // Logger.firestore.info("Firestore disposed");
    Logger.firestore.info("### Firestore disposed");
  }

  /// Takes the raw JSON snapshot coming from Firestore and attempts to
  /// convert it into a [GameRoom].
  GameRoom _convertFromRemote(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) {
      // Logger.firestore.info("No data found on Firestore, returning empty list");
      Logger.firestore.info("### Firestore - No data found on Firestore, returning empty list");
      return GameRoom.empty();
    }

    try {
      return GameRoom.fromJson(data);
    } catch (e) {
      throw FirebaseControllerException(
        // 'Failed to parse data from Firestore: $e',
        '### Firestore - Failed to parse data from Firestore: $e',
      );
    }
  }

  /// Takes a list of [GameRoom]s and converts it into a JSON object
  /// that can be saved into Firestore.
  Map<String, Object?> _convertLocalToFirestore(
      GameRoom room, SetOptions? options) {
    return room.toJson();
  }

  /// Updates Firestore with the local state of the [GameRoom].
  void _updateFirestoreFromLocal(
    GameRoom room,
    DocumentReference<GameRoom> ref,
  ) async {
    try {
      Logger.firestore.info(
        // "Updating Firestore with local data (${room.toJson()}) ...",
        "### Firestore - Updating Firestore with local data (${room.toJson()}) ...",
      );

      await ref.set(room);
      // Logger.firestore.info("... done updating.");
      Logger.firestore.info("### ... done updating.");
    } catch (e) {
      throw FirebaseControllerException(
        // 'Failed to update Firestore with local data (${room.toJson()}): $e',
        '### Firestore - Failed to update Firestore with local data (${room.toJson()}): $e',
      );
    }
  }

  /// Updates the local state of [room] with the data from Firestore.
  void _updateLocalFromFirestore(
    GameRoom room,
    DocumentSnapshot<GameRoom> snapshot,
  ) {
    // TODO: data is received but not updated on screen.
    Logger.firestore.info(
      // "Received new data from Firestore (${snapshot.data()?.toJson()})",
      "### Firestore - Received new data from Firestore (${snapshot.data()?.toJson()})",
    );

    final remoteRoom = snapshot.data() ?? GameRoom.empty();
    print("### Firestore - remoteRoom: ${remoteRoom.toJson()} ###");
    print("### Firestore - localRoom: ${room.toJson()} ###");

    print("### Firestore - Local data needs update: ${room != remoteRoom} ###");
    if (room != remoteRoom) {
      Logger.firestore.info(
        // "Updating local data with Firestore data (${remoteRoom.toJson()})",
        "### Firestore - Updating local data with Firestore data (${remoteRoom.toJson()})",
      );

      this.room = room.copyWith(
        config: remoteRoom.config,
        playerList: remoteRoom.playerList,
      );

      Logger.firestore.info(
        // "Local data updated (${room.toJson()})",
        "### Firestore - Local data updated (${this.room.toJson()})",
      );
    }
  }
}

class FirebaseControllerException implements Exception {
  final String message;

  FirebaseControllerException(this.message);

  @override
  // String toString() => 'FirebaseControllerException: $message';
  String toString() => '### Firestore FirebaseControllerException: $message';
}
