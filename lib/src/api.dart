import 'package:flutter/services.dart';

import 'enum/log_level.dart';
import 'utility/json.dart';

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
  final List<Json> observations;

  ResponseApi({
    required this.requestId,
    required this.observations,
  });

  factory ResponseApi.fromJson(Json json) {
    final requestId = json.str('request_id');
    final observations = json.jsonList('results');
    return ResponseApi(requestId: requestId, observations: observations);
  }
}
