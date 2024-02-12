import 'package:flutter/services.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

enum Method {
  analyze,
  supportedRecognitionLanguages,
  ;

  static const _channel = MethodChannel('unified_apple_vision');

  Future<Map<String, dynamic>?> invoke(
    VisionLogLevel logLevel, [
    Map<String, dynamic>? arg,
  ]) async {
    final input = {
      'log_level': logLevel.name,
      ...arg ?? {},
    };
    return _channel.invokeMapMethod<String, dynamic>(name, input);
  }
}
