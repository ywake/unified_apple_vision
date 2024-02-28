import 'package:flutter/foundation.dart';
import 'package:unified_apple_vision/src/enum/log_level.dart';
import 'package:unified_apple_vision/src/extension/optional.dart';

class Logger {
  VisionLogLevel threshold = VisionLogLevel.debug;

  void log({
    required VisionLogLevel level,
    required LogSide side,
    required String msg,
    String? symbol,
  }) {
    if (level.index >= threshold.index) {
      debugPrint('${level.emoji} '
          '[unified_apple_vision${side.emoji}${symbol.maybe((s) => '>$s') ?? ''}] '
          '$msg');
    }
  }

  void d(String s, [String? symbol]) => log(
        level: VisionLogLevel.debug,
        side: LogSide.dart,
        msg: s,
        symbol: symbol,
      );

  void i(String s, [String? symbol]) => log(
        level: VisionLogLevel.info,
        side: LogSide.dart,
        msg: s,
        symbol: symbol,
      );

  void w(String s, [String? symbol]) => log(
        level: VisionLogLevel.warning,
        side: LogSide.dart,
        msg: s,
        symbol: symbol,
      );

  void e(String s, {Object? error, StackTrace? stackTrace, String? symbol}) {
    log(
      level: VisionLogLevel.error,
      side: LogSide.dart,
      msg: s,
      symbol: symbol,
    );
    if (error != null) {
      debugPrint(error.toString());
    }
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }
}

extension LogLevelEx on VisionLogLevel {
  String get emoji => switch (this) {
        VisionLogLevel.debug => '',
        VisionLogLevel.info => 'ℹ️',
        VisionLogLevel.warning => '🟡',
        VisionLogLevel.error => '🚫',
        VisionLogLevel.none => '',
      };
}

enum LogSide {
  swift('🍏'),
  dart('🎯'),
  ;

  final String emoji;
  const LogSide(this.emoji);
}
