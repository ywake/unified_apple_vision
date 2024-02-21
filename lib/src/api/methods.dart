import 'package:flutter/services.dart';

enum Method {
  setLogLevel,
  analyze,
  // supportedRecognitionLanguages,
  computeDistance,
  ;

  static const channel = MethodChannel('unified_apple_vision/method');

  Future<Map<String, dynamic>?> invoke([Map<String, dynamic>? arg]) async =>
      channel.invokeMapMethod<String, dynamic>(name, arg);
}
