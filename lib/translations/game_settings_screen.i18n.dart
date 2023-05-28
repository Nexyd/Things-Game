import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "Game settings",
        "es_es": "Configuración de partida",
      } + {
        "en_gb": "Create a room",
        "es_es": "Crear sala",
      } +
      {
        "en_gb": "Create",
        "es_es": "Crear",
      };

  String get i18n => localize(this, _t);
}