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
  ;

  String get key => switch (this) {
        VisionRequestType.recognizeText => 'recognize_text',
        VisionRequestType.detectRectangles => 'detect_rectangles',
        VisionRequestType.trackObject => 'track_object',
        VisionRequestType.trackRectangle => 'track_rectangle',
        VisionRequestType.recognizeAnimals => 'recognize_animals',
        VisionRequestType.detectTextRectangles => 'detect_text_rectangles',
        VisionRequestType.detectBarcodes => 'detect_barcodes',
        VisionRequestType.detectHumanRectangles => 'detect_human_rectangles',
        VisionRequestType.detectFaceRectangles => 'detect_face_rectangles',
        VisionRequestType.detectFaceLandmarks => 'detect_face_landmarks',
        VisionRequestType.detectFaceCaptureQuality =>
          'detect_face_capture_quality',
        VisionRequestType.classifyImage => 'classify_image',
        VisionRequestType.generateImageFeaturePrint =>
          'generate_image_feature_print',
      };
}
