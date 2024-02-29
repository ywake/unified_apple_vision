import 'package:unified_apple_vision/src/model/enum/image_crop_and_scale_option.dart';
import 'package:unified_apple_vision/src/model/request/image_based.dart';

/// **iOS 11.0+, macOS 10.13+**
abstract class VisionCoreMLRequest extends VisionImageBasedRequest {
  final VisionImageCropAndScaleOption? imageCropAndScaleOption;

  const VisionCoreMLRequest({
    this.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
    required super.type,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'image_crop_and_scale_option': imageCropAndScaleOption?.name,
    };
  }
}
