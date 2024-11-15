import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:things_game/support/logger.dart';

class AppLifecycleManager {
  static AppLifecycleManager? _instance;
  static AppLifecycleManager get I => _instance!;

  final List<String> _states = <String>[];
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;
  late Function()? _onExit;

  static void initState({required Function() onExit}) {
    if (_instance != null) return;

    _instance = AppLifecycleManager();
    _instance!._onExit = onExit;
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
    if (state == AppLifecycleState.detached) _onExit?.call();
    Logger.global.info('AppLifecycleState: ${state.name}');
  }
}