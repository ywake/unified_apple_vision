import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/recognized_object.dart';

import 'request.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request that recognizes animals in an image.
///
/// Vision returns the result of this request in a [VisionRecognizedObjectObservation] object.
class VisionRecognizeAnimalsRequest extends VisionRequest {
  const VisionRecognizeAnimalsRequest({
    required super.onResults,
  }) : super(type: VisionRequestType.recognizeAnimals);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
