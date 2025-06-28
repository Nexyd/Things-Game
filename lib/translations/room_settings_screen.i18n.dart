import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      const {
        ENG_LANG: "Game settings",
        ESP_LANG: "Configuración de partida",
      } + {
        ENG_LANG: "Create a room",
        ESP_LANG: "Crear sala",
      };

  String get i18n => localize(this, _t);
}