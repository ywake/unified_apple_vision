import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'image_based.dart';

/// **iOS 11.0+, macOS 10.13+**
class VisionDetectFaceRectanglesRequest extends VisionImageBasedRequest {
  const VisionDetectFaceRectanglesRequest({
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.detectFaceRectangles);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }
}
