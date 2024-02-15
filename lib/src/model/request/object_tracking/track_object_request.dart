import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/detected_object.dart';
import 'package:unified_apple_vision/src/model/request/object_tracking/tracking_request.dart';

///An image analysis request that tracks the movement of a previously identified object across multiple images or video frames.
class VisionTrackObjectRequest extends VisionTrackingRequest {
  final VisionDetectedObjectObservation target;

  const VisionTrackObjectRequest({
    required this.target,
    super.trackingLevel,
    super.isLastFrame,
  }) : super(type: VisionRequestType.trackObject);

  @override
  Map<String, dynamic> toMap() {
    return {
      'input': target.toMap(),
      'tracking_level': trackingLevel.name,
      'is_last_frame': isLastFrame,
    };
  }
}
