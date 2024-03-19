import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'base.dart';

/// **iOS 12.0+, macOS 10.14+**
class VisionCoreMLRecognizeRequest extends VisionCoreMLRequest {
  const VisionCoreMLRecognizeRequest({
    required super.modelPath,
    super.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.coreMlRecognize);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }
}
