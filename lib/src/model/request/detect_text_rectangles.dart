import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/request/analysis_request.dart';

/// **iOS 11.0+, macOS 10.13+**
///
/// An image analysis request that finds regions of visible text in an image.
///
/// This request returns detected text characters as rectangular bounding boxes with origin and size.
class VisionDetectTextRectanglesRequest extends AnalysisRequest {
  /// A Boolean value that indicates whether the request detects character bounding boxes.
  final bool? reportCharacterBoxes;

  const VisionDetectTextRectanglesRequest({
    this.reportCharacterBoxes,
  }) : super(type: VisionRequestType.detectTextRectangles);

  @override
  Map<String, dynamic> toMap() {
    return {
      'reportCharacterBoxes': reportCharacterBoxes,
    };
  }
}
