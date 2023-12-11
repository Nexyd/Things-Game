// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:things_game/cubit/model/game_board.dart';
// import 'package:things_game/cubit/model/game_room.dart';
//
// class FirestoreBoardController {
//   final FirebaseFirestore instance;
//   final String roomId;
//
//   late final _boardRef = instance
//       .collection('boards')
//       .doc(roomId)
//       .withConverter<GameBoard>(
//           fromFirestore: _convertFromRemote,
//           toFirestore: _convertFromLocal
//       );
//
//   StreamSubscription? _boardRemoteSubscription;
//   StreamSubscription? _boardLocalSubscription;
//
//   FirestoreBoardController({required this.instance, required this.roomId}) {
//     _boardRemoteSubscription = _boardRef.snapshots().listen((snapshot) {
//       _updateLocalFromFirestore(boardState.areaTwo, snapshot);
//     });
//
//     _boardLocalSubscription = boardState.areaTwo.localChanges.listen((_) {
//       _updateFirestoreFromLocal(boardState.areaTwo, _boardRef);
//     });
//
//     //_log.fine('Initialized');
//   }
//
//   void dispose() {
//     _boardRemoteSubscription?.cancel();
//     _boardLocalSubscription?.cancel();
//
//     //_log.fine('Disposed');
//   }
//
//   /// Takes the raw JSON snapshot coming from Firestore and attempts to
//   /// convert it into a [GameBoard].
//   GameBoard _convertFromRemote(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) {
//     final data = snapshot.data()?['cards'];
//
//     if (data == null) {
//       //_log.info('No data found on Firestore, returning empty list');
//       return GameBoard.empty();
//     }
//
//     final list = List.castFrom<Object?, Map<String, Object?>>(data);
//
//     try {
//       return list.map((raw) => PlayingCard.fromJson(raw)).toList();
//     } catch (e) {
//       throw FirebaseControllerException(
//           'Failed to parse data from Firestore: $e');
//     }
//   }
//
//   /// Takes a list of [PlayingCard]s and converts it into a JSON object
//   /// that can be saved into Firestore.
//   Map<String, Object?> _convertFromLocal(GameBoard board, SetOptions? options) {
//     return {'cards': cards.map((c) => c.toJson()).toList()};
//   }
//
//   /// Updates Firestore with the local state of [board].
//   void _updateFirestoreFromLocal(
//     GameBoard board,
//     DocumentReference<GameBoard> ref,
//   ) async {
//     try {
//       //_log.fine('Updating Firestore with local data (${area.cards}) ...');
//       await ref.set(area.cards);
//       //_log.fine('... done updating.');
//     } catch (e) {
//       throw FirebaseControllerException(
//         'Failed to update Firestore with local data (${area.cards}): $e',
//       );
//     }
//   }
//
//   /// Updates the local state of [board] with the data from Firestore.
//   void _updateLocalFromFirestore(
//     GameBoard board,
//     DocumentSnapshot<GameBoard> snapshot,
//   ) {
//     //_log.fine('Received new data from Firestore (${snapshot.data()})');
//     final remoteBoard = snapshot.data() ?? GameBoard.empty();
//
//     if (board == remoteBoard) {
//       //_log.fine('No change');
//     } else {
//       //_log.fine('Updating local data with Firestore data ($cards)');
//       area.replaceWith(cards);
//     }
//   }
// }
//
// class FirebaseControllerException implements Exception {
//   final String message;
//
//   FirebaseControllerException(this.message);
//
//   @override
//   String toString() => 'FirebaseControllerException: $message';
// }
