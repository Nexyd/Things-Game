part of "../theme_switcher_cubit.dart";

@immutable
abstract class ThemeSwitcherState {}

class ThemeSwitcherInitial extends ThemeSwitcherState {}

class ThemeSwitcherUpdated extends ThemeSwitcherState {
  final ThemeData theme;

  ThemeSwitcherUpdated({required this.theme});
}