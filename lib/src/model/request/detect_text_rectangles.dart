import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/text.dart';

import 'request.dart';

/// **iOS 11.0+, macOS 10.13+**
///
/// An image analysis request that finds regions of visible text in an image.
///
/// This request returns detected text characters as rectangular bounding boxes with origin and size.
///
class VisionDetectTextRectanglesRequest extends VisionRequest {
  /// A Boolean value that indicates whether the request detects character bounding boxes.
  final bool? reportCharacterBoxes;

  const VisionDetectTextRectanglesRequest({
    this.reportCharacterBoxes,
    required super.onResult,
  }) : super(type: VisionRequestType.detectTextRectangles);

  @override
  Map<String, dynamic> toMap() {
    return {
      'reportCharacterBoxes': reportCharacterBoxes,
    };
  }

  @override
  List<VisionTextObservation> toObservations(
      List<Map<String, dynamic>> results) {
    return [
      for (final result in results) VisionTextObservation.fromMap(result)
    ];
  }
}
