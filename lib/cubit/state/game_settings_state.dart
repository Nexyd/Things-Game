import 'package:flutter/cupertino.dart';

@immutable
abstract class GameSettingsState {}

class GameSettingsInitial extends GameSettingsState {}

class GameSettingsError extends GameSettingsState {}