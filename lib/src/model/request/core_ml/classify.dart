import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'base.dart';

/// **iOS 11.0+, macOS 10.13+**
class VisionCoreMLClassifyRequest extends VisionCoreMLRequest {
  const VisionCoreMLClassifyRequest({
    required super.modelPath,
    super.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.coreMlClassify);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }
}
