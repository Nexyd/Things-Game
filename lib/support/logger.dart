import 'package:loggy/loggy.dart';

enum LoggerLevel { debug, info, warning, error }

enum LoggerType {
  global,
  settings,
  dio,
  room,
  game,
  user,
}

class LoggerConfig {
  final List<LoggerType> blacklist;
  final List<LoggerType> whitelist;

  final LoggerLevel level;

  LoggerConfig({
    this.whitelist = const [],
    this.blacklist = const [],
    this.level = LoggerLevel.info,
  });
}

final Map<LoggerLevel, LogLevel> _levels = {
  LoggerLevel.info: LogLevel.info,
  LoggerLevel.debug: LogLevel.debug,
  LoggerLevel.warning: LogLevel.warning,
  LoggerLevel.error: LogLevel.error,
};

final Map<LoggerType, Type> _types = {
  LoggerType.global: GlobalLoggy,
  LoggerType.settings: SettingsLoggy,
  LoggerType.dio: DioLoggy,
  LoggerType.room: RoomLoggy,
  LoggerType.game: GameLoggy,
  LoggerType.user: UserLoggy
};

class Logger {
  static void init(LoggerConfig? config) {
    config ??= LoggerConfig();
    final LogLevel level = _levels[config.level] ?? LogLevel.info;

    final List<Type> blacklist = config.blacklist
        .map((loggerType) => _types[loggerType] ?? GlobalLoggy)
        .toList();

    final List<Type> whitelist = config.whitelist
        .map((loggerType) => _types[loggerType] ?? GlobalLoggy)
        .toList();

    final List<LoggyFilter> filters = [];

    if (blacklist.isNotEmpty) {
      filters.add(BlacklistFilter(blacklist));
    }

    if (whitelist.isNotEmpty) {
      filters.add(WhitelistFilter(whitelist));
    }

    // TODO: add colored log printer.
    Loggy.initLoggy(
      logOptions: LogOptions(level),
      logPrinter: const PrettyPrinter(showColors: true),
      filters: filters,
    );
  }

  static final Loggy global = Loggy<GlobalLoggy>('Global');
  static final Loggy settings = Loggy<SettingsLoggy>('Settings');
  static final Loggy dio = Loggy<DioLoggy>('Dio');
  static final Loggy room = Loggy<RoomLoggy>('Room');
  static final Loggy game = Loggy<GameLoggy>('Game');
  static final Loggy user = Loggy<UserLoggy>('User');
}

class SettingsLoggy implements LoggyType {
  @override
  Loggy<SettingsLoggy> get loggy => Loggy<SettingsLoggy>('Settings');
}

class DioLoggy implements LoggyType {
  @override
  Loggy<DioLoggy> get loggy => Loggy<DioLoggy>('Dio');
}

class RoomLoggy implements LoggyType {
  @override
  Loggy<RoomLoggy> get loggy => Loggy<RoomLoggy>('Room');
}

class GameLoggy implements LoggyType {
  @override
  Loggy<GameLoggy> get loggy => Loggy<GameLoggy>('Game');
}

class UserLoggy implements LoggyType {
  @override
  Loggy<UserLoggy> get loggy => Loggy<UserLoggy>('User');
}
