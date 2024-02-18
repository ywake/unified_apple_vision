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
        }
    ]);
  }

  List<VisionDetectedObjectObservation> get ofTrackObjectRequest =>
      observations.cast<VisionDetectedObjectObservation>();

  List<VisionRectangleObservation> get ofTrackRectangleRequest =>
      observations.cast<VisionRectangleObservation>();

  List<VisionBarcodeObservation> get ofDetectBarcodesRequest =>
      observations.cast<VisionBarcodeObservation>();

  List<VisionRectangleObservation> get ofDetectRectanglesRequest =>
      observations.cast<VisionRectangleObservation>();

  List<VisionTextObservation> get ofDetectTextRectanglesRequest =>
      observations.cast<VisionTextObservation>();

  List<VisionRecognizedObjectObservation> get ofRecognizeAnimalsRequest =>
      observations.cast<VisionRecognizedObjectObservation>();

  List<VisionRecognizedTextObservation> get ofRecognizeTextRequest =>
      observations.cast<VisionRecognizedTextObservation>();
}
