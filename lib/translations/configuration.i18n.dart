import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "Players",
        "es_es": "Jugadores",
      } +
      {
        "en_gb": "Rounds",
        "es_es": "Rondas",
      } +
      {
        "en_gb": "Max. points",
        "es_es": "Puntos",
      } +
      {
        "en_gb": "Private",
        "es_es": "Privada",
      };

  String get i18n => localize(this, _t);
}