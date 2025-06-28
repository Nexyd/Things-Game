import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      // Error
      const {
        ENG_LANG: "Error",
        ESP_LANG: "Error",
      } +
      {
        ENG_LANG: "An error has occurred",
        ESP_LANG: "Ha ocurrido un error",
      } +
      {
        ENG_LANG: "Accept",
        ESP_LANG: "Aceptar",
      } +

      // Exit app
      {
        ENG_LANG: "Exit app?",
        ESP_LANG: "Salir de la aplicación?",
      } +
      {
        ENG_LANG: "YES",
        ESP_LANG: "SI",
      } +
      {
        ENG_LANG: "NO",
        ESP_LANG: "NO",
      };

  String get i18n => localize(this, _t);
}