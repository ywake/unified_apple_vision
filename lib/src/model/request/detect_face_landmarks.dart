import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'request.dart';

/// **iOS 11.0+, macOS 10.13+**
class VisionDetectFaceLandmarksRequest extends VisionRequest {
  /// **iOS 13.0+, macOS 10.15+**
  ///
  /// A variable that describes how a face landmarks request orders or enumerates the resulting features.
  ///
  /// Set this variable to one of the supported constellation types detailed in [VisionRequestFaceLandmarksConstellation]. The default value is [VisionRequestFaceLandmarksConstellation.constellationNotDefined].
  final VisionRequestFaceLandmarksConstellation? constellation;

  const VisionDetectFaceLandmarksRequest({
    this.constellation,
    required super.onResults,
  }) : super(type: VisionRequestType.detectFaceLandmarks);

  @override
  Map<String, dynamic> toMap() {
    return {
      'constellation': constellation?.name,
    };
  }
}

/// **iOS 13.0+, macOS 10.15+**
///
/// An enumeration of face landmarks in a constellation object.
enum VisionRequestFaceLandmarksConstellation {
  constellationNotDefined,
  constellation65Points,
  constellation76Points,
}
