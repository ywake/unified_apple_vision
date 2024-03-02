import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/request_error.dart';
import 'package:unified_apple_vision/src/model/results.dart';

typedef VisionRequestCallback = void Function(VisionResults results);
typedef VisionRequestErrorCallback = void Function(VisionRequestError error);

abstract class VisionRequest {
  final VisionRequestType type;
  final VisionRequestCallback onResults;
  final VisionRequestErrorCallback? onError;

  const VisionRequest({
    required this.type,
    required this.onResults,
    this.onError,
  });

  /// In the child class override, super.toMap() must be concatenated.
  Map<String, dynamic> toMap() {
    return {
      'request_type': type.key,
    };
  }
}
