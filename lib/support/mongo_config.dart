import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:realm/realm.dart';

class MongoConfig {
  static late MongoConfig _instance;
  static MongoConfig get I => _instance;

  late String appId;
  late String atlasUrl;
  late Uri baseUrl;
  late User user;

  bool _isInitialized = false;


  MongoConfig._create(dynamic realmConfig) {
    appId = realmConfig['appId'];
    atlasUrl = realmConfig['dataExplorerLink'];
    baseUrl = Uri.parse(realmConfig['baseUrl']);
  }

  Future<void> init(String jsonPath) async {
    if (!_isInitialized) {
      await _init(jsonPath);
      _isInitialized = true;
    }
  }

  Future<void> _init(String jsonPath) async {
    final realmConfig = json.decode(
      await rootBundle.loadString(jsonPath),
    );

    _instance = MongoConfig._create(realmConfig);
    final app = App(AppConfiguration(appId, baseUrl: baseUrl));
    user = await app.logIn(Credentials.anonymous());
  }
}
