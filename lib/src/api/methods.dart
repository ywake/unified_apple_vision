import 'package:flutter/services.dart';

enum Method {
  logging,
  analyze,
  // supportedRecognitionLanguages,
  // computeDistance,
  ;

  static const channel = MethodChannel('unified_apple_vision/method');

  Future<bool?> invoke([Map<String, dynamic>? arg]) async {
    return channel.invokeMethod<bool>(name, arg);
  }
}
