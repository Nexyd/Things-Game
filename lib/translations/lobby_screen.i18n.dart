import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "Lobby id",
        "es_es": "Id de la sala",
      } +
      {
        "en_gb": "Rounds",
        "es_es": "Rondas",
      } +
      {
        "en_gb": "Max. points",
        "es_es": "Puntos",
      } +
      {
        "en_gb": "Private",
        "es_es": "Privada",
      } +
      {
        "en_gb": "Start/Ready",
        "es_es": "Empezar/Listo",
      } +
      {
        "en_gb": "Ready",
        "es_es": "Listo",
      } +
      {
        "en_gb": "Leave room",
        "es_es": "Abandonar sala",
      };

  String get i18n => localize(this, _t);
}