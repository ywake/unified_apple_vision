import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'base.dart';

/// **iOS 11.0+, macOS 10.13+**
class VisionCoreMLClassifyRequest extends VisionCoreMLRequest {
  /// The path to the **Compiled** Core ML model file.
  /// To compile a Core ML model, use the `compileModel()` method.
  final String modelPath;

  const VisionCoreMLClassifyRequest({
    required this.modelPath,
    super.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.coreMlClassify);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'model_path': modelPath,
    };
  }
}
