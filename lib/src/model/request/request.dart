import 'package:flutter/foundation.dart';
import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/results.dart';

typedef VisionRequestCallback = void Function(VisionResults results);

abstract class VisionRequest {
  final VisionRequestType type;
  final VisionRequestCallback onResults;

  const VisionRequest({required this.type, required this.onResults});

  Map<String, dynamic> encode() {
    final map = toMap();
    if (map.containsKey('request_type')) {
      throw Exception('The key "request_type" is reserved');
    }

    return {
      'request_type': type.key,
      ...map,
    };
  }

  @protected
  Map<String, dynamic> toMap();
}
