import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "Search room",
        "es_es": "Buscar sala",
      } +
      {
        "en_gb": "Room id",
        "es_es": "Id de sala",
      } +
      {
        "en_gb": "Open games",
        "es_es": "Partidas abiertas",
      } +
      {
        "en_gb": "No games available",
        "es_es": "No hay partidas disponibles",
      } +
      {
        "en_gb": "Retry",
        "es_es": "Intentar de nuevo",
      };

  String get i18n => localize(this, _t);
}