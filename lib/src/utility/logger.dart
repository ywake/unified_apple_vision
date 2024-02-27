import 'package:flutter/foundation.dart';
import 'package:unified_apple_vision/src/enum/log_level.dart';

class Logger {
  VisionLogLevel threshold = VisionLogLevel.debug;

  void log(VisionLogLevel logLevel, String s) {
    if (logLevel.index >= threshold.index) {
      debugPrint('[$logLevel] $s');
    }
  }

  void d(String s) => log(VisionLogLevel.debug, s);
  void i(String s) => log(VisionLogLevel.info, s);
  void w(String s) => log(VisionLogLevel.warning, s);
  void e(String s, {Object? error, StackTrace? stackTrace}) {
    log(VisionLogLevel.error, s);
    if (error != null) {
      debugPrint(error.toString());
    }
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }
}

extension LogLevelEx on VisionLogLevel {
  static const _loggerLevels = <VisionLogLevel, String>{
    VisionLogLevel.debug: 'D',
    VisionLogLevel.info: 'I',
    VisionLogLevel.warning: 'W',
    VisionLogLevel.error: 'E',
    VisionLogLevel.none: 'N',
  };

  String get loggerLevel => _loggerLevels[this]!;
}
