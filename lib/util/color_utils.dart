import 'dart:ui';

extension ColorUtils on Color {
  Color shade([int value = 10]) {
    return Color.fromRGBO(
      red <= (255 - value) ? red + value : red - value,
      green <= (255 - value) ? green + value : green - value,
      blue <= (255 - value) ? blue + value : blue - value,
      opacity,
    );
  }
}