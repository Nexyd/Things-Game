import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      const {
        ENG_LANG: "Search room",
        ESP_LANG: "Buscar sala",
      } +
      {
        ENG_LANG: "Room id",
        ESP_LANG: "Id de sala",
      } +
      {
        ENG_LANG: "Open games",
        ESP_LANG: "Partidas abiertas",
      } +
      {
        ENG_LANG: "No games available",
        ESP_LANG: "No hay partidas disponibles",
      } +
      {
        ENG_LANG: "Retry",
        ESP_LANG: "Intentar de nuevo",
      };

  String get i18n => localize(this, _t);
}