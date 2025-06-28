import 'package:i18n_extension/i18n_extension.dart';

import '../support/constants.dart';

extension Localization on String {
  static final _t = Translations.byText(ENG_LANG) +
      const {
        ENG_LANG: "Create game",
        ESP_LANG: "Crear partida",
      } +
      {
        ENG_LANG: "Join game",
        ESP_LANG: "Unirse a partida",
      };

  String get i18n => localize(this, _t);
}