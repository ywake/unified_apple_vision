import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'observations/vision_barcode_observation.dart';
import 'observations/vision_classification_observation.dart';
import 'observations/vision_face_observation.dart';
import 'observations/vision_human_observation.dart';
import 'observations/vision_recognized_text_observation.dart';
import 'observations/vision_rectangle_observation.dart';
import 'observations/vision_text_observation.dart';

extension VisionRequestTypeEx on VisionRequestType {
  DropdownMenuEntry<VisionRequestType> get dropdownMenuEntry {
    return DropdownMenuEntry(value: this, label: name);
  }

  List<VisionRequest> requests(void Function(VisionResults) onResults) => [
        switch (this) {
          VisionRequestType.recognizeText => VisionRecognizeTextRequest(
              automaticallyDetectsLanguage: true, onResults: onResults),
          VisionRequestType.detectRectangles =>
            VisionDetectRectanglesRequest(onResults: onResults),
          VisionRequestType.recognizeAnimals =>
            VisionRecognizeAnimalsRequest(onResults: onResults),
          VisionRequestType.detectTextRectangles =>
            VisionDetectTextRectanglesRequest(onResults: onResults),
          VisionRequestType.detectBarcodes =>
            VisionDetectBarcodesRequest(onResults: onResults),
          VisionRequestType.detectHumanRectangles =>
            VisionDetectHumanRectanglesRequest(
                upperBodyOnly: true, onResults: onResults),
          VisionRequestType.detectFaceRectangles =>
            VisionDetectFaceRectanglesRequest(onResults: onResults),
          VisionRequestType.detectFaceLandmarks =>
            VisionDetectFaceLandmarksRequest(onResults: onResults),
          VisionRequestType.detectFaceCaptureQuality =>
            VisionDetectFaceCaptureQualityRequest(onResults: onResults),
          VisionRequestType.trackObject ||
          VisionRequestType.trackRectangle =>
            null,
        }
      ].nonNulls.toList();

  List<Widget>? widgets(VisionResults? result) {
    switch (this) {
      case VisionRequestType.recognizeText:
        return result?.ofRecognizeTextRequest.map((e) => e.build()).toList();
      case VisionRequestType.detectRectangles:
        return result?.ofDetectRectanglesRequest.map((e) => e.build()).toList();
      case VisionRequestType.recognizeAnimals:
        return result?.ofRecognizeAnimalsRequest.map((e) => e.build()).toList();
      case VisionRequestType.detectTextRectangles:
        return result?.ofDetectTextRectanglesRequest
            .map((e) => e.build())
            .toList();
      case VisionRequestType.detectBarcodes:
        return result?.ofDetectBarcodesRequest.map((e) => e.build()).toList();
      case VisionRequestType.detectHumanRectangles:
        return result?.ofDetectHumanRectanglesRequest
            .map((e) => e.build())
            .toList();
      case VisionRequestType.detectFaceRectangles:
      case VisionRequestType.detectFaceLandmarks:
      case VisionRequestType.detectFaceCaptureQuality:
        return result?.observations
            .whereType<VisionFaceObservation>()
            .map((e) => e.build())
            .toList();
      case VisionRequestType.trackObject:
      case VisionRequestType.trackRectangle:
        return [const Center(child: Text('Not available yet.'))];
    }
  }
}
