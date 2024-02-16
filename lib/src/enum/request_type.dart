import 'package:unified_apple_vision/src/model/observation/text.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:unified_apple_vision/src/extension/map.dart';

typedef Factory = List<VisionObservation>? Function(Map<String, dynamic> map);

enum VisionRequestType {
  recognizeText,
  detectRectangles,
  trackObject,
  trackRectangle,
  recognizeAnimals,
  detectTextRectangles,
  ;

  String get key => switch (this) {
        VisionRequestType.recognizeText => 'recognize_text',
        VisionRequestType.detectRectangles => 'detect_rectangles',
        VisionRequestType.trackObject => 'track_object',
        VisionRequestType.trackRectangle => 'track_rectangle',
        VisionRequestType.recognizeAnimals => 'recognize_animals',
        VisionRequestType.detectTextRectangles => 'detect_text_rectangles',
      };

  List<VisionObservation> fromListMap(List<Map> observations) {
    return [
      for (final observation in observations)
        switch (this) {
          VisionRequestType.recognizeText =>
            VisionRecognizedTextObservation.fromMap(observation.castEx()),
          VisionRequestType.detectRectangles =>
            VisionRectangleObservation.fromMap(observation.castEx()),
          VisionRequestType.trackObject =>
            VisionDetectedObjectObservation.fromMap(observation.castEx()),
          VisionRequestType.trackRectangle =>
            VisionRectangleObservation.fromMap(observation.castEx()),
          VisionRequestType.recognizeAnimals =>
            VisionRecognizedObjectObservation.fromMap(observation.castEx()),
          VisionRequestType.detectTextRectangles =>
            VisionTextObservation.fromMap(observation.castEx()),
        },
    ];
  }

  List<Map<String, dynamic>> toListMap(List<VisionObservation> observations) {
    return [
      for (final observation in observations)
        switch (this) {
          VisionRequestType.recognizeText =>
            (observation as VisionRecognizedTextObservation).toMap(),
          VisionRequestType.detectRectangles =>
            (observation as VisionRectangleObservation).toMap(),
          VisionRequestType.trackObject =>
            (observation as VisionDetectedObjectObservation).toMap(),
          VisionRequestType.trackRectangle =>
            (observation as VisionRectangleObservation).toMap(),
          VisionRequestType.recognizeAnimals =>
            (observation as VisionRecognizedObjectObservation).toMap(),
          VisionRequestType.detectTextRectangles =>
            (observation as VisionTextObservation).toMap(),
        },
    ];
  }
}
