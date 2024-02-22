import 'package:unified_apple_vision/src/model/request/image_based.dart';

/// The abstract superclass for image analysis requests that track unique features across multiple images or video frames.
abstract class VisionTrackingRequest extends VisionImageBasedRequest {
  /// A value for specifying whether to prioritize speed or location accuracy.
  final VisionTrackingLevel trackingLevel;

  /// A Boolean that indicates the last frame in a tracking sequence.
  final bool isLastFrame;

  const VisionTrackingRequest({
    this.trackingLevel = VisionTrackingLevel.accurate,
    this.isLastFrame = false,
    required super.type,
    required super.regionOfInterest,
    required super.onResults,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'tracking_level': trackingLevel.name,
      'is_last_frame': isLastFrame,
    };
  }
}

/// A value for specifying whether to prioritize speed or location accuracy.
enum VisionTrackingLevel {
  /// Tracking level that favors speed over location accuracy.
  fast,

  /// Tracking level that favors location accuracy over speed.
  accurate,
  ;
}
