import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      const {
        ENG_LANG: "User settings",
        ESP_LANG: "Preferencias",
      } +
      {
        ENG_LANG: "Name",
        ESP_LANG: "Nombre",
      } +
      {
        ENG_LANG: "Avatar",
        ESP_LANG: "Avatar",
      } +
      {
        ENG_LANG: "Primary color",
        ESP_LANG: "Color principal",
      } +
      {
        ENG_LANG: "Text color",
        ESP_LANG: "Color de texto",
      } +
      {
        ENG_LANG: "Background color",
        ESP_LANG: "Color de fondo",
      } +
      {
        ENG_LANG: "Language",
        ESP_LANG: "Idioma",
      } +
      {
        ENG_LANG: "Spanish",
        ESP_LANG: "Español",
      } +
      {
        ENG_LANG: "English",
        ESP_LANG: "Inglés",
      };

  String get i18n => localize(this, _t);
}