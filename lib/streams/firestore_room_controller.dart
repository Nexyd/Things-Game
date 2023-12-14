import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/cubit/model/game_room.dart';

import '../support/logger.dart';

class FirestoreRoomController {
  late final FirebaseFirestore _firestore;
  GameRoom room;

  late final roomRef = _firestore
      .collection('rooms')
      .doc(room.id)
      .withConverter<GameRoom>(
          fromFirestore: _convertFromRemote,
          toFirestore: (room, options) => room.toJson());

  StreamSubscription? _roomLocalSubscription;

  FirestoreRoomController({required this.room}) {
    _firestore = FirebaseFirestore.instance;
    _roomLocalSubscription = room.localChanges.listen(
      (_) => _updateFirestoreFromLocal(room, roomRef),
    );

    Logger.firestore.info("Firestore initialized");
  }

  void dispose() {
    _roomLocalSubscription?.cancel();
    room = GameRoom.empty();
    Logger.firestore.info("Firestore disposed");
  }

  /// Takes the raw JSON snapshot coming from Firestore and attempts to
  /// convert it into a [GameRoom].
  GameRoom _convertFromRemote(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) {
      Logger.firestore.info("No data found, returning empty room.");
      return GameRoom.empty();
    }

    try {
      return GameRoom.fromJson(data);
    } catch (e) {
      throw FirestoreControllerException(
        'Failed to parse data from Firestore: $e',
      );
    }
  }

  /// Updates Firestore with the local state of the [GameRoom].
  void _updateFirestoreFromLocal(
    GameRoom room,
    DocumentReference<GameRoom> ref,
  ) async {
    try {
      Logger.firestore.info("Updating Firestore with local data...");
      await ref.set(room);

      Logger.firestore.info("Firestore updated!");
    } catch (e) {
      throw FirestoreControllerException(
        'Failed to update Firestore with local data (${room.toJson()}): $e',
      );
    }
  }
}

class FirestoreControllerException implements Exception {
  final String message;

  FirestoreControllerException(this.message);

  @override
  String toString() => 'FirestoreControllerException: $message';
}
