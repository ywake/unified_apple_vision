import 'package:flutter/services.dart';

enum Method {
  analyze,
  supportedRecognitionLanguages,
  ;

  static const _channel = MethodChannel('unified_apple_vision');

  Future<Map<String, dynamic>?> invoke([Map<String, dynamic>? arg]) async {
    return _channel.invokeMapMethod<String, dynamic>(name, arg);
  }
}
