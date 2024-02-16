import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/request/analysis_request.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// A request that recognizes animals in an image.
///
class VisionRecognizeAnimalsRequest extends AnalysisRequest {
  const VisionRecognizeAnimalsRequest()
      : super(type: VisionRequestType.recognizeAnimals);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
