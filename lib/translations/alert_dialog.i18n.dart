import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      // Error
      const {
        "en_gb": "Error",
        "es_es": "Error",
      } +
      {
        "en_gb": "An error has occurred",
        "es_es": "Ha ocurrido un error",
      } +
      {
        "en_gb": "Accept",
        "es_es": "Aceptar",
      } +

      // Exit app
      {
        "en_gb": "Exit app?",
        "es_es": "Salir de la aplicación?",
      } +
      {
        "en_gb": "YES",
        "es_es": "SI",
      } +
      {
        "en_gb": "NO",
        "es_es": "NO",
      };

  String get i18n => localize(this, _t);
}