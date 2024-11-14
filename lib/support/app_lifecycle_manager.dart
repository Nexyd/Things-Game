import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:things_game/support/logger.dart';

class AppLifecycleManager {
  static AppLifecycleManager? _instance;
  static AppLifecycleManager get I => _instance!;

  late final AppLifecycleListener _listener;
  final List<String> _states = <String>[];
  late AppLifecycleState? _state;

  static void initState() {
    if (_instance != null) return;

    _instance = AppLifecycleManager();
    _instance!._state = SchedulerBinding.instance.lifecycleState;

    _instance!._listener = AppLifecycleListener(
      onStateChange: _instance!._handleStateChange,
      onExitRequested: () => _instance!._handleExit(),
    );

    if (_instance!._state != null) {
      _instance!._states.add(_instance!._state!.name);
    }
  }

  Future<AppExitResponse> _handleExit() async {
    return AppExitResponse.exit;
  }

  void dispose() => _listener.dispose();

  void _handleStateChange(AppLifecycleState state) {
    Logger.global.info('AppLifecycleState: ${state.name}');
  }
}