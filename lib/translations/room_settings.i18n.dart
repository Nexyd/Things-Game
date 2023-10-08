import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_gb") +
      const {
        "en_gb": "Room name",
        "es_es": "Nombre de la sala",
      } + {
        "en_gb": "Players",
        "es_es": "Jugadores",
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
        "en_gb": "Create",
        "es_es": "Crear",
      } +

      // Validation Errors
      {
        "en_gb": "The number of players must be greater than 2",
        "es_es": "El número de jugadores debe ser superior a 2",
      } +
      {
        "en_gb": "The value must be greater than 0",
        "es_es": "El valor debe ser superior a 0",
      } +
      {
        "en_gb": "This field is mandatory",
        "es_es": "Este campo es obligatorio",
      };

  String get i18n => localize(this, _t);
}