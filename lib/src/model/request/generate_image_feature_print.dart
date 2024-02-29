import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/enum/image_crop_and_scale_option.dart';
import 'package:unified_apple_vision/src/model/observation/feature_print.dart';

import 'image_based.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// An image-based request to generate feature prints from an image. (FeaturePrint — vector image descriptor similar to a word vector)
///
/// This request returns the feature print data it generates as an array of [VisionFeaturePrintObservation] objects.
class VisionGenerateImageFeaturePrintRequest extends VisionImageBasedRequest {
  /// An optional setting that tells the algorithm how to scale an input image before generating the feature print.
  ///
  /// Scaling is applied before generating the feature print. The default value is [VisionImageCropAndScaleOption.scaleFill].
  ///
  /// Scaling an image ensures that the entire image fits into the algorithm's input image dimensions, which may require a change in aspect ratio. Each crop and scale option transforms the input image in a different way
  final VisionImageCropAndScaleOption? imageCropAndScaleOption;

  const VisionGenerateImageFeaturePrintRequest({
    this.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.generateImageFeaturePrint);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'image_crop_and_scale_option': imageCropAndScaleOption?.name,
    };
  }
}
