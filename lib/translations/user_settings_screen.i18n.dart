import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "User settings",
        "es_es": "Preferencias",
      } +
      {
        "en_gb": "Name",
        "es_es": "Nombre",
      } +
      {
        "en_gb": "Avatar",
        "es_es": "Avatar",
      } +
      {
        "en_gb": "Primary color",
        "es_es": "Color principal",
      } +
      {
        "en_gb": "Text color",
        "es_es": "Color de texto",
      } +
      {
        "en_gb": "Background color",
        "es_es": "Color de fondo",
      } +
      {
        "en_gb": "Language",
        "es_es": "Idioma",
      } +
      {
        "en_gb": "Spanish",
        "es_es": "Español",
      } +
      {
        "en_gb": "English",
        "es_es": "Inglés",
      };

  String get i18n => localize(this, _t);
}