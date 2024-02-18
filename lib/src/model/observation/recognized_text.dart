import 'dart:ui';

import 'package:unified_apple_vision/src/model/request/recognize_text.dart';
import 'package:unified_apple_vision/src/utility/json.dart';

import 'rectangle.dart';

class VisionRecognizedTextObservation extends VisionRectangleObservation {
  /// List of candidates for recognition results. The maximum number is specified by [VisionRecognizeTextRequest.maxCandidates] in descending order of accuracy.
  final List<VisionRecognizedTextCandidate> candidates;

  VisionRecognizedTextObservation.withParent({
    required VisionRectangleObservation parent,
    required this.candidates,
  }) : super.clone(parent);

  VisionRecognizedTextObservation.clone(VisionRecognizedTextObservation other)
      : this.withParent(
          parent: other,
          candidates: other.candidates,
        );

  factory VisionRecognizedTextObservation.fromJson(Json json) {
    return VisionRecognizedTextObservation.withParent(
      parent: VisionRectangleObservation.fromJson(json),
      candidates:
          json.objList('candidates', VisionRecognizedTextCandidate.fromJson),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'candidates': [for (final c in candidates) c.toMap()],
    };
  }

  @override
  VisionRecognizedTextObservation copyWith({
    List<VisionRecognizedTextCandidate>? candidates,
    Offset? topLeft,
    Offset? topRight,
    Offset? bottomLeft,
    Offset? bottomRight,
    Rect? boundingBox,
    String? uuid,
    double? confidence,
  }) {
    return VisionRecognizedTextObservation.withParent(
      candidates: candidates ?? this.candidates,
      parent: super.copyWith(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        boundingBox: boundingBox,
        uuid: uuid,
        confidence: confidence,
      ),
    );
  }
}

/// Text recognized in an image through a text recognition request.
class VisionRecognizedTextCandidate {
  /// The top candidate for recognized text.
  final String text;

  /// A normalized confidence score for the text recognition result.
  final double confidence;

  const VisionRecognizedTextCandidate({
    required this.text,
    required this.confidence,
  });

  factory VisionRecognizedTextCandidate.fromJson(Json json) {
    return VisionRecognizedTextCandidate(
      text: json.str('string'),
      confidence: json.double_('confidence'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'confidence': confidence,
    };
  }
}
