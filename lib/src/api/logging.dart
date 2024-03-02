import 'package:unified_apple_vision/src/api/methods.dart';
import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/src/utility/logger.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

class LoggingApi {
  final Logger _logger;

  LoggingApi(this._logger);

  Future<void> setLogLevel(VisionLogLevel level) async {
    _logger.threshold = level;
    try {
      await Method.logging.invoke(VisionExecutionPriority.medium, {
        'level': level.name,
      });
    } catch (e) {
      rethrow;
    }
  }

  void onResults(Json json) {
    final log = _LogData.fromJson(json);
    _logger.log(
      level: log.level,
      side: LogSide.swift,
      msg: log.message,
      symbol: log.symbol,
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
