import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/recognized_object.dart';

import 'image_based.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request that recognizes animals in an image.
///
/// Vision returns the result of this request in a [VisionRecognizedObjectObservation] object.
class VisionRecognizeAnimalsRequest extends VisionImageBasedRequest {
  const VisionRecognizeAnimalsRequest({
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.recognizeAnimals);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }
}
