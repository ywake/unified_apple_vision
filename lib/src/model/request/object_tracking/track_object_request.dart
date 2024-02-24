import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/detected_object.dart';
import 'package:unified_apple_vision/src/model/request/object_tracking/tracking_request.dart';

/// **iOS 11.0+, macOS 10.13+**
///
/// An image analysis request that tracks the movement of a previously identified object across multiple images or video frames.
///
/// Use this type of request to track the bounding boxes around objects previously identified in an image. Vision attempts to locate the same object from the input observation throughout the sequence.
///
/// Vision returns locations for objects found in all orientations and sizes as [VisionDetectedObjectObservation].
class VisionTrackObjectRequest extends VisionTrackingRequest {
  final VisionDetectedObjectObservation target;

  const VisionTrackObjectRequest({
    required this.target,
    super.trackingLevel,
    super.isLastFrame,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.trackObject);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'input': target.toMap(),
    };
  }
}
