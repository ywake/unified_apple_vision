import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/recognized_object.dart';

import 'request.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request that recognizes animals in an image.
///
class VisionRecognizeAnimalsRequest extends VisionRequest {
  const VisionRecognizeAnimalsRequest({
    required super.onResult,
  }) : super(type: VisionRequestType.recognizeAnimals);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  List<VisionRecognizedObjectObservation> toObservations(
      List<Map<String, dynamic>> results) {
    return [
      for (final result in results)
        VisionRecognizedObjectObservation.fromMap(result),
    ];
  }
}
