import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "Create game",
        "es_es": "Crear partida",
      } +
      {
        "en_gb": "Join game",
        "es_es": "Unirse a partida",
      };

  String get i18n => localize(this, _t);
}