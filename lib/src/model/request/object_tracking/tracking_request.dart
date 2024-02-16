import 'package:unified_apple_vision/src/enum/tracking_level.dart';
import 'package:unified_apple_vision/src/model/request/analysis_request.dart';

/// The abstract superclass for image analysis requests that track unique features across multiple images or video frames.
abstract class VisionTrackingRequest extends AnalysisRequest {
  /// A value for specifying whether to prioritize speed or location accuracy.
  final VisionTrackingLevel trackingLevel;

  /// A Boolean that indicates the last frame in a tracking sequence.
  final bool isLastFrame;

  const VisionTrackingRequest({
    required super.type,
    this.trackingLevel = VisionTrackingLevel.accurate,
    this.isLastFrame = false,
  });
}
