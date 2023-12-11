import 'dart:async';

import 'package:async/async.dart';

mixin Streamable<T> {
  final _localChanges = StreamController<T>.broadcast();
  final _remoteChanges = StreamController<T>.broadcast();

  /// A [Stream] that fires an event every time any change to this area is made.
  Stream<T> get allChanges =>
      StreamGroup.mergeBroadcast([remoteChanges, localChanges]);

  /// A [Stream] that fires an event every time a change is made _locally_,
  /// by the player.
  Stream<T> get localChanges => _localChanges.stream;

  /// A [Stream] that fires an event every time a change is made _remotely_,
  /// by another player.
  Stream<T> get remoteChanges => _remoteChanges.stream;
}
