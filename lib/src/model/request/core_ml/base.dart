import 'package:unified_apple_vision/src/model/enum/image_crop_and_scale_option.dart';
import 'package:unified_apple_vision/src/model/request/image_based.dart';

/// **iOS 11.0+, macOS 10.13+**
abstract class VisionCoreMLRequest extends VisionImageBasedRequest {
  /// The path to the **Compiled** Core ML model file.
  /// To compile a Core ML model, use the `compileModel()` method.
  final String modelPath;

  /// An optional setting that tells the Vision algorithm how to scale an input image.
  final VisionImageCropAndScaleOption? imageCropAndScaleOption;

  const VisionCoreMLRequest({
    required this.modelPath,
    this.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
    required super.type,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'model_path': modelPath,
      'image_crop_and_scale_option': imageCropAndScaleOption?.name,
    };
  }
}
