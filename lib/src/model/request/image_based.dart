import 'dart:ui';

import 'package:unified_apple_vision/src/extension/rect.dart';

import 'request.dart';

/// The abstract superclass for image analysis requests that focus on a specific part of an image.
///
/// Other Vision request handlers that operate on still images inherit from this abstract base class.
abstract class VisionImageBasedRequest extends VisionRequest {
  /// The region of the image in which Vision will perform the request.
  ///
  /// The rectangle is normalized to the dimensions of the processed image. Its origin is specified relative to the image's upper-left corner.
  ///
  /// The default value is `{ { 0, 0 }, { 1, 1 } }`.
  final Rect? regionOfInterest;

  const VisionImageBasedRequest({
    required this.regionOfInterest,
    required super.type,
    required super.onResults,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'region_of_interest': regionOfInterest?.toMap(),
    };
  }
}
