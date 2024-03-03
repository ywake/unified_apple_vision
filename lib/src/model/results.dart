import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

// FIXME: Maybe there is a better way.
class VisionResults {
  final List<VisionObservation> observations;

  VisionResults(this.observations);

  factory VisionResults.fromJsonList({
    required VisionRequestType type,
    required List<Json> data,
  }) {
    return VisionResults([
      for (final json in data)
        switch (type) {
          VisionRequestType.recognizeText =>
            VisionRecognizedTextObservation.fromJson(json),
          VisionRequestType.detectRectangles =>
            VisionRectangleObservation.fromJson(json),
          VisionRequestType.trackObject =>
            VisionDetectedObjectObservation.fromJson(json),
          VisionRequestType.trackRectangle =>
            VisionRectangleObservation.fromJson(json),
          VisionRequestType.recognizeAnimals =>
            VisionRecognizedObjectObservation.fromJson(json),
          VisionRequestType.detectTextRectangles =>
            VisionTextObservation.fromJson(json),
          VisionRequestType.detectBarcodes =>
            VisionBarcodeObservation.fromJson(json),
          VisionRequestType.detectHumanRectangles =>
            VisionHumanObservation.fromJson(json),
          VisionRequestType.detectFaceRectangles =>
            VisionFaceObservation.fromJson(json),
          VisionRequestType.detectFaceLandmarks =>
            VisionFaceObservation.fromJson(json),
          VisionRequestType.detectFaceCaptureQuality =>
            VisionFaceObservation.fromJson(json),
          VisionRequestType.classifyImage =>
            VisionClassificationObservation.fromJson(json),
          VisionRequestType.generateImageFeaturePrint =>
            VisionFeaturePrintObservation.fromJson(json),
          VisionRequestType.coreMlClassify =>
            VisionClassificationObservation.fromJson(json),
          VisionRequestType.coreMlRecognize =>
            VisionRecognizedObjectObservation.fromJson(json),
        }
    ]);
  }

  List<VisionDetectedObjectObservation> get ofTrackObjectRequest =>
      observations.whereType<VisionDetectedObjectObservation>().toList();

  List<VisionRectangleObservation> get ofTrackRectangleRequest =>
      observations.whereType<VisionRectangleObservation>().toList();

  List<VisionBarcodeObservation> get ofDetectBarcodesRequest =>
      observations.whereType<VisionBarcodeObservation>().toList();

  List<VisionRectangleObservation> get ofDetectRectanglesRequest =>
      observations.whereType<VisionRectangleObservation>().toList();

  List<VisionTextObservation> get ofDetectTextRectanglesRequest =>
      observations.whereType<VisionTextObservation>().toList();

  List<VisionRecognizedObjectObservation> get ofRecognizeAnimalsRequest =>
      observations.whereType<VisionRecognizedObjectObservation>().toList();

  List<VisionRecognizedTextObservation> get ofRecognizeTextRequest =>
      observations.whereType<VisionRecognizedTextObservation>().toList();

  List<VisionHumanObservation> get ofDetectHumanRectanglesRequest =>
      observations.whereType<VisionHumanObservation>().toList();

  List<VisionFaceObservation> get ofDetectFaceRectanglesRequest =>
      observations.whereType<VisionFaceObservation>().toList();

  List<VisionFaceObservation> get ofDetectFaceLandmarksRequest =>
      observations.whereType<VisionFaceObservation>().toList();

  List<VisionFaceObservation> get ofDetectFaceCaptureQualityRequest =>
      observations.whereType<VisionFaceObservation>().toList();

  List<VisionClassificationObservation> get ofClassifyImageRequest =>
      observations.whereType<VisionClassificationObservation>().toList();

  List<VisionFeaturePrintObservation> get ofGenerateImageFeaturePrintRequest =>
      observations.whereType<VisionFeaturePrintObservation>().toList();

  List<VisionClassificationObservation> get ofCoreMlClassifyRequest =>
      observations.whereType<VisionClassificationObservation>().toList();

  List<VisionRecognizedObjectObservation> get ofCoreMlRecognizeRequest =>
      observations.whereType<VisionRecognizedObjectObservation>().toList();
}
