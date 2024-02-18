import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/detected_object.dart';
import 'package:unified_apple_vision/src/model/request/object_tracking/tracking_request.dart';

/// **iOS 11.0+, macOS 10.13+**
///
/// An image analysis request that tracks the movement of a previously identified object across multiple images or video frames.
///
/// Use this type of request to track the bounding boxes around objects previously identified in an image. Vision attempts to locate the same object from the input observation throughout the sequence.
///
class VisionTrackObjectRequest extends VisionTrackingRequest {
  final VisionDetectedObjectObservation target;

  const VisionTrackObjectRequest({
    required this.target,
    super.trackingLevel,
    super.isLastFrame,
    required super.onResult,
  }) : super(type: VisionRequestType.trackObject);

  @override
  Map<String, dynamic> toMap() {
    return {
      'input': target.toMap(),
      'tracking_level': trackingLevel.name,
      'is_last_frame': isLastFrame,
    };
  }

  @override
  List<VisionDetectedObjectObservation> toObservations(
      List<Map<String, dynamic>> results) {
    return [
      for (final result in results)
        VisionDetectedObjectObservation.fromMap(result)
    ];
  }
}
