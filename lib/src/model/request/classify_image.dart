import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/classification.dart';

import 'image_based.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request to classify an image.
///
/// This type of request produces a collection of [VisionClassificationObservation] objects that describe an image.
class VisionClassifyImageRequest extends VisionImageBasedRequest {
  const VisionClassifyImageRequest({
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.classifyImage);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }
}
