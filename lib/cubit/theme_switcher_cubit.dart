import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:things_game/config/theme_data_manager.dart';
import 'package:things_game/config/user_settings.dart';

part 'state/theme_switcher_state.dart';

class ThemeSwitcherCubit extends Cubit<ThemeSwitcherState> {
  ThemeSwitcherCubit() : super(ThemeSwitcherInitial());

  void updateTheme() {
    if (!UserSettings.isInit) {
      _emitUpdateTheme(isInit: false);
      return;
    }

    _emitUpdateTheme(isInit: true);
  }

  void _emitUpdateTheme({required bool isInit}) {
    final background = Colors.grey.shade800;
    final theme = ThemeDataManager.build(
      primary: isInit ? UserSettings.I.primaryColor : Colors.red,
      background: isInit ? UserSettings.I.backgroundColor : background,
      text: isInit ? UserSettings.I.textColor : Colors.white,
    );

    emit(ThemeSwitcherUpdated(theme: theme));
  }
}
