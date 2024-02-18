import 'package:flutter/foundation.dart';
import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/observation.dart';

typedef VisionRequestCallback<T> = void Function(
    List<VisionObservation> results);

abstract class VisionRequest {
  final VisionRequestType type;
  final VisionRequestCallback onResult;

  const VisionRequest({required this.type, required this.onResult});

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
  List<VisionObservation> toObservations(List<Map<String, dynamic>> results);
}
