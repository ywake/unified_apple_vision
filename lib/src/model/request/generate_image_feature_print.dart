import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/feature_print.dart';

import 'request.dart';

/// **iOS 13.0+, macOS 10.15+**
///
/// An image-based request to generate feature prints from an image. (FeaturePrint — vector image descriptor similar to a word vector)
///
/// This request returns the feature print data it generates as an array of [VisionFeaturePrintObservation] objects.
class VisionGenerateImageFeaturePrintRequest extends VisionRequest {
  /// An optional setting that tells the algorithm how to scale an input image before generating the feature print.
  ///
  /// Scaling is applied before generating the feature print. The default value is [VisionImageCropAndScaleOption.scaleFill].
  ///
  /// Scaling an image ensures that the entire image fits into the algorithm's input image dimensions, which may require a change in aspect ratio. Each crop and scale option transforms the input image in a different way
  final VisionImageCropAndScaleOption? imageCropAndScaleOption;

  const VisionGenerateImageFeaturePrintRequest({
    this.imageCropAndScaleOption,
    required super.onResults,
  }) : super(type: VisionRequestType.generateImageFeaturePrint);

  @override
  Map<String, dynamic> toMap() {
    return {
      'imageCropAndScaleOption': imageCropAndScaleOption?.name,
    };
  }
}

/// Options that define how Vision crops and scales an input-image.
///
/// Scaling an image ensures that it fits within the algorithm’s input image dimensions, which may require a change in aspect ratio. The figure below shows how each crop-and-scale option transforms the input image: <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
enum VisionImageCropAndScaleOption {
  /// An option that scales the image to fit its shorter side within the input dimensions, while preserving its aspect ratio, and center-crops the image.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  centerCrop,

  /// An option that scales the image to fit its longer side within the input dimensions, while preserving its aspect ratio, and center-crops the image.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFit,

  /// An option that scales the image to fill the input dimensions, resizing it if necessary.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFill,

  /// An option that rotates the image 90 degrees counterclockwise and then scales it, while preserving its aspect ratio, to fit on the long side.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFitRotate90CCW,

  /// An option that rotates the image 90 degrees counterclockwise and then scales it to fill the input dimensions.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFillRotate90CCW,
}
