import 'package:flutter/services.dart';
import 'package:unified_apple_vision/src/enum/execution_priority.dart';

enum Method {
  logging,
  analyze,
  coreML,
  // supportedRecognitionLanguages,
  // computeDistance,
  ;

  static const channel = MethodChannel('unified_apple_vision/method');

  Future<bool> invoke(
    VisionExecutionPriority priority, [
    Map<String, dynamic>? arg,
  ]) async {
    try {
      final res = await channel.invokeMethod<bool>(name, {
        'priority': priority.taskPriority,
        ...?arg,
      });
      return res ?? false;
    } catch (e) {
      rethrow;
    }
  }
}
