import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'request.dart';

/// **iOS 11.0+, macOS 10.13+**
class VisionDetectFaceRectanglesRequest extends VisionRequest {
  const VisionDetectFaceRectanglesRequest({
    required super.onResults,
  }) : super(type: VisionRequestType.detectFaceRectangles);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
