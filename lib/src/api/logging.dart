import 'package:logger/logger.dart';
import 'package:unified_apple_vision/src/api/methods.dart';
import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

class LoggingApi {
  final Logger _logger;

  LoggingApi(this._logger);

  Future<void> setLogLevel(VisionLogLevel level) async {
    Logger.level = level.loggerLevel;
    await Method.logging.invoke({'level': level.name});
  }

  void onResults(Json json) {
    final log = _LogData.fromJson(json);
    _logger.log(
      log.level.loggerLevel,
      '[unified_apple_vision${log.symbol == null ? '' : '>${log.symbol}'}]\n'
      '${log.message}',
    );
  }
}

class _LogData {
  final VisionLogLevel level;
  final String message;
  final String? symbol;

  _LogData({
    required this.level,
    required this.message,
    this.symbol,
  });

  factory _LogData.fromJson(Json json) {
    return _LogData(
      level: json.enum_('level', VisionLogLevel.values),
      message: json.str('message'),
      symbol: json.strOr('symbol'),
    );
  }
}
