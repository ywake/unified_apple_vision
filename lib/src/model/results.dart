import 'package:flutter/foundation.dart';
import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/input_image.dart';
import 'package:unified_apple_vision/src/model/observation/barcode.dart';
import 'package:unified_apple_vision/src/model/observation/observation.dart';
import 'package:unified_apple_vision/src/model/observation/recognized_object.dart';
import 'package:unified_apple_vision/src/model/observation/recognized_text.dart';
import 'package:unified_apple_vision/src/model/observation/rectangle.dart';
import 'package:unified_apple_vision/src/model/observation/text.dart';

class VisionResults {
  final VisionInputImage inputImage;
  final Map<VisionRequestType, List<VisionObservation>> observations;

  VisionResults({
    required this.inputImage,
    required this.observations,
  });

  factory VisionResults.fromMap(
    VisionInputImage image,
    Map<String, dynamic> map,
  ) {
    final observations = <VisionRequestType, List<VisionObservation>>{};
    for (final type in VisionRequestType.values) {
      if (!map.containsKey(type.key)) continue;
      try {
        observations[type] =
            type.fromListMap((map[type.key] as List).cast<Map>());
      } catch (e, st) {
        debugPrint('Failed to parse ${type.key}. skipping...');
        debugPrint('$e');
        debugPrint('$st');
      }
    }
    return VisionResults(inputImage: image, observations: observations);
  }

  Map<String, dynamic> toMap() {
    return {
      for (final type in VisionRequestType.values)
        if (observations.containsKey(type))
          type.key: type.toListMap(observations[type]!),
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  bool has(VisionRequestType type) => observations.containsKey(type);
  List<T>? get<T>(VisionRequestType type) => observations[type]?.cast<T>();

  List<VisionRecognizedTextObservation>? get recognizedText =>
      get<VisionRecognizedTextObservation>(VisionRequestType.recognizeText);
  List<VisionRectangleObservation>? get detectedRectangles =>
      get<VisionRectangleObservation>(VisionRequestType.detectRectangles);
  // List<VisionDetectedObjectObservation>? get trackObjects =>
  //     get<VisionDetectedObjectObservation>(VisionRequestType.trackObject);
  // List<VisionRectangleObservation>? get trackRectangles =>
  //     get<VisionRectangleObservation>(VisionRequestType.trackRectangle);
  List<VisionRecognizedObjectObservation>? get recognizedAnimals =>
      get<VisionRecognizedObjectObservation>(
          VisionRequestType.recognizeAnimals);
  List<VisionTextObservation>? get detectedTextRectangles =>
      get<VisionTextObservation>(VisionRequestType.detectTextRectangles);
  List<VisionBarcodeObservation>? get detectedBarcodes =>
      get<VisionBarcodeObservation>(VisionRequestType.detectBarcodes);
}
