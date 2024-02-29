import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'base.dart';

/// **iOS 11.0+, macOS 10.13+**
abstract class VisionCoreMLClassificationRequest extends VisionCoreMLRequest {
  /// The name of the model to be used for classification. (snake_case)
  final String modelName;

  const VisionCoreMLClassificationRequest({
    required this.modelName,
    super.imageCropAndScaleOption,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.coreMlClassification);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'model_name': modelName,
    };
  }
}
