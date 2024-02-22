import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/results.dart';

typedef VisionRequestCallback = void Function(VisionResults results);

abstract class VisionRequest {
  final VisionRequestType type;
  final VisionRequestCallback onResults;

  const VisionRequest({required this.type, required this.onResults});

  /// In the child class override, super.toMap() must be concatenated.
  Map<String, dynamic> toMap() {
    return {
      'request_type': type.key,
    };
  }
}
