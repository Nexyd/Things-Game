import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      const {
        ENG_LANG: "Room name",
        ESP_LANG: "Nombre de la sala",
      } + {
        ENG_LANG: "Players",
        ESP_LANG: "Jugadores",
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
        ENG_LANG: "Create",
        ESP_LANG: "Crear",
      } +

      // Validation Errors
      {
        ENG_LANG: "The number of players must be greater than 2",
        ESP_LANG: "El número de jugadores debe ser superior a 2",
      } +
      {
        ENG_LANG: "The value must be greater than 0",
        ESP_LANG: "El valor debe ser superior a 0",
      } +
      {
        ENG_LANG: "This field is mandatory",
        ESP_LANG: "Este campo es obligatorio",
      };

  String get i18n => localize(this, _t);
}