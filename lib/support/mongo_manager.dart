import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:realm/realm.dart';

import 'package:things_game/model/realm_models.dart';

class MongoConfig {
  final String appId;
  final String atlasUrl;
  final Uri baseUrl;

  MongoConfig({
    required this.appId,
    required this.atlasUrl,
    required this.baseUrl,
  });
}

class MongoManager {
  static MongoManager? _instance;
  static MongoManager get I => _instance!;

  late MongoConfig config;
  late User user;
  late Configuration roomConfig;
  late Configuration boardConfig;

  static Future<void> init(String jsonPath) async {
    if (_instance == null) {
      _instance = MongoManager();
      await _instance!._init(jsonPath);
    }
  }

  Future<void> _init(String jsonPath) async {
    _instance = MongoManager();
    final realmConfig = json.decode(
      await rootBundle.loadString(jsonPath),
    );

    _instance!.config = MongoConfig(
      appId: realmConfig['appId'],
      atlasUrl: realmConfig['dataExplorerLink'],
      baseUrl: Uri.parse(realmConfig['baseUrl']),
    );

    final app = App(AppConfiguration(
      _instance!.config.appId,
      baseUrl: _instance!.config.baseUrl,
    ));

    _instance!.user = await app.logIn(Credentials.anonymous());
    _setRealmConfigs();
  }

  void _setRealmConfigs() {
    _instance!.roomConfig = Configuration.flexibleSync(
      _instance!.user,
      [GameRoomDB.schema, ConfigurationDataDB.schema, PlayerDB.schema],
    );

    _instance!.boardConfig = Configuration.flexibleSync(
      _instance!.user,
      [GameBoardDB.schema, QuestionBoardDB.schema, AssignmentDB.schema],
    );
  }
}
