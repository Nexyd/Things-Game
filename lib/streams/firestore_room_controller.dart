import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:things_game/cubit/model/game_room.dart';
import 'package:things_game/support/logger.dart';

class FirestoreRoomController {
  late final FirebaseFirestore _firestore;
  StreamSubscription? _roomLocalSubscription;
  GameRoom room;

  FirestoreRoomController({required this.room}) {
    _firestore = FirebaseFirestore.instance;
    _roomLocalSubscription = room.localChanges.listen(
      (data) => _updateFirestoreFromLocal(data, roomRef),
    );

    Logger.firestore.info("Firestore initialized");
  }

  void dispose() {
    _roomLocalSubscription?.cancel();
    room = GameRoom.empty();
    Logger.firestore.info("Firestore disposed");
  }

  DocumentReference<GameRoom> get roomRef =>
      _firestore.collection('rooms').doc(room.id).withConverter<GameRoom>(
            fromFirestore: _convertFromRemote,
            toFirestore: (room, options) => room.toJson(),
          );

  Stream<DocumentSnapshot<GameRoom>> get roomStream => roomRef.snapshots();

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
      throw FirestoreRoomControllerException(
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
      //await ref.set(room, SetOptions(merge: true));

      try {
        await ref.update(room.toJson());
      } catch (error) {
        Logger.firestore.warning("Document not found, creating...");
        await ref.set(room, SetOptions(merge: true));
      }

      Logger.firestore.info("Firestore updated!");
    } catch (e) {
      throw FirestoreRoomControllerException(
        'Failed to update Firestore with local data (${room.toJson()}): $e',
      );
    }
  }
}

// class FirestoreRoomController {
//   late final FirebaseFirestore _firestore;
//   GameRoom room;
//
//   FirestoreRoomController({required this.room}) {
//     _firestore = FirebaseFirestore.instance;
//     Logger.firestore.info("Room controller initialized");
//   }
//
//   void dispose() {
//     room = GameRoom.empty();
//     Logger.firestore.info("Room controller disposed");
//   }
//
//   DocumentReference<Map<String, dynamic>> get roomRef =>
//       _firestore.collection('rooms').doc(room.id);
// }

class FirestoreRoomControllerException implements Exception {
  final String message;

  FirestoreRoomControllerException(this.message);

  @override
  String toString() => 'FirestoreRoomControllerException: $message';
}
