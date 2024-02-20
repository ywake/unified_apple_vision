import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/face/observation.dart';

import 'request.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request that produces a floating-point number that represents the capture quality of a face in a photo.
///
/// This request produces or updates a [VisionFaceObservation] object’s property [VisionFaceObservation.faceCaptureQuality] with a floating-point value. The value ranges from 0 to 1. Faces with quality closer to 1 are better lit, sharper, and more centrally positioned than faces with quality closer to 0.
///
/// If you don’t execute the request, or the request fails, the property [VisionFaceObservation.faceCaptureQuality] is nil.
class VisionDetectFaceCaptureQualityRequest extends VisionRequest {
  const VisionDetectFaceCaptureQualityRequest({
    required super.onResults,
  }) : super(type: VisionRequestType.detectFaceCaptureQuality);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
