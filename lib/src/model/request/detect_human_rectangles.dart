import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/human.dart';

import 'image_based.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request that finds rectangular regions that contain people in an image.
///
/// This request returns an array of [VisionHumanObservation] objects, one for each rectangular region it detects.
class VisionDetectHumanRectanglesRequest extends VisionImageBasedRequest {
  /// **iOS 15.0+, macOS 12.0+**
  /// A Boolean value that indicates whether the request requires detecting a full body or upper body only to produce a result.
  ///
  /// The default value of true indicates that the request requires detecting a person’s upper body only to find the bound box around it.
  final bool? upperBodyOnly;

  const VisionDetectHumanRectanglesRequest({
    this.upperBodyOnly,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.detectHumanRectangles);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'upper_body_only': upperBodyOnly,
    };
  }
}
