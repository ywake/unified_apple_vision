import 'package:unified_apple_vision/src/model/observation/observation.dart';

typedef Factory = List<VisionObservation>? Function(Map<String, dynamic> map);

enum VisionRequestType {
  recognizeText,
  detectRectangles,
  trackObject,
  trackRectangle,
  recognizeAnimals,
  detectTextRectangles,
  detectBarcodes,
  detectHumanRectangles,
  detectFaceRectangles,
  detectFaceLandmarks,
  detectFaceCaptureQuality,
  classifyImage,
  generateImageFeaturePrint,
  coreMlClassify,
  ;

  String get key {
    return name
        .replaceAllMapped(
          RegExp(r'(?<=[a-z])[A-Z]'),
          (match) => '_${match.group(0)}',
        )
        .toLowerCase();
  }
}
