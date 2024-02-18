import 'package:flutter/services.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'extension/list.dart';

enum Method {
  analyze,
  supportedRecognitionLanguages,
  ;

  static const channel = MethodChannel('unified_apple_vision/method');

  Future<Map<String, dynamic>?> invoke(
    VisionLogLevel logLevel, [
    Map<String, dynamic>? arg,
  ]) async {
    final input = {
      'log_level': logLevel.name,
      ...arg ?? {},
    };
    return channel.invokeMapMethod<String, dynamic>(name, input);
  }
}

class ResponseApi {
  final String requestId;
  final List<Map<String, dynamic>> observations;

  ResponseApi({
    required this.requestId,
    required this.observations,
  });

  factory ResponseApi.fromMap(Map<String, dynamic> map) {
    final requestId = map['request_id'] as String?;
    final observations = (map['results'] as List?)?.castMap();
    if (requestId == null || observations == null) {
      throw Exception('Failed to parse ResponseApi from Map');
    }
    return ResponseApi(requestId: requestId, observations: observations);
  }
}
