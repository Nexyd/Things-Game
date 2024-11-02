import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things_game/cubit/theme_switcher_cubit.dart';

import 'package:things_game/main.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  const ThemeSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeSwitcherCubit cubit = BlocProvider.of(context);
    cubit.updateTheme();

    return BlocBuilder<ThemeSwitcherCubit, ThemeSwitcherState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is ThemeSwitcherInitial) return CircularProgressIndicator();

        state as ThemeSwitcherUpdated;
        return ThingsGameView(themeData: state.theme);
      },
    );
  }
}
