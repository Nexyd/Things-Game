import 'dart:ui';

extension ColorUtils on Color {
  Color shade([int value = 10]) {
    return Color.fromRGBO(
      r.toInt() <= (255 - value) ? r.toInt() + value : r.toInt() - value,
      g.toInt() <= (255 - value) ? g.toInt() + value : g.toInt() - value,
      b.toInt() <= (255 - value) ? b.toInt() + value : b.toInt() - value,
      a,
    );
  }
}