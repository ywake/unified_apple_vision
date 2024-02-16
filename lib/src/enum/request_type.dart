import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

typedef Factory = List<VisionObservation>? Function(Map<String, dynamic> map);

enum VisionRequestType {
  recognizeText,
  trackObject,
  trackRectangle,
  ;

  String get key => switch (this) {
        VisionRequestType.recognizeText => 'recognize_text',
        VisionRequestType.trackObject => 'track_object',
        VisionRequestType.trackRectangle => 'track_rectangle',
      };

  List<VisionObservation> fromMap(Map<String, dynamic> map) {
    final observations = map['observations'] as List?;
    if (observations == null) {
      throw Exception('map[$key]["observations"] is null.');
    }

    return [
      for (final observation in observations.cast<Map>())
        switch (this) {
          VisionRequestType.recognizeText =>
            VisionRecognizedTextObservation.fromMap(observation.castEx()),
          VisionRequestType.trackObject =>
            VisionDetectedObjectObservation.fromMap(observation.castEx()),
          VisionRequestType.trackRectangle =>
            VisionRectangleObservation.fromMap(observation.castEx()),
        },
    ];
  }

  List<Map<String, dynamic>> toListMap(List<VisionObservation> observations) {
    return [
      for (final observation in observations)
        switch (this) {
          VisionRequestType.recognizeText =>
            (observation as VisionRecognizedTextObservation).toMap(),
          VisionRequestType.trackObject =>
            (observation as VisionDetectedObjectObservation).toMap(),
          VisionRequestType.trackRectangle =>
            (observation as VisionRectangleObservation).toMap(),
        },
    ];
  }
}
