import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      const {
        ENG_LANG: "Lobby id",
        ESP_LANG: "Id de la sala",
      } +
      {
        ENG_LANG: "Rounds",
        ESP_LANG: "Rondas",
      } +
      {
        ENG_LANG: "Max. points",
        ESP_LANG: "Puntos",
      } +
      {
        ENG_LANG: "Private",
        ESP_LANG: "Privada",
      } +
      {
        ENG_LANG: "Start/Ready",
        ESP_LANG: "Empezar/Listo",
      } +
      {
        ENG_LANG: "Ready",
        ESP_LANG: "Listo",
      } +
      {
        ENG_LANG: "Leave room",
        ESP_LANG: "Abandonar sala",
      };

  String get i18n => localize(this, _t);
}