import 'dart:ui';

import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/model/request/recognize_text_request.dart';

import 'rectangle.dart';

class VisionRecognizedTextObservation extends VisionRectangleObservation {
  /// List of candidates for recognition results. The maximum number is specified by [VisionRecognizeTextRequest.maxCandidates] in descending order of accuracy.
  final List<VisionRecognizedTextCandidate> candidates;

  /// The coordinates are normalized to the image size, with the top-left corner being (0.0, 0.0) and the bottom-right corner being (1.0, 1.0).
  // final VisionRectangleObservation rectangle;

  // VisionRecognizedTextObservation({
  //   required this.candidates,
  //   required super.topLeft,
  //   required super.topRight,
  //   required super.bottomLeft,
  //   required super.bottomRight,
  //   required super.boundingBox,
  //   required super.uuid,
  //   required super.confidence,
  // });

  VisionRecognizedTextObservation.withParent({
    required VisionRectangleObservation parent,
    required this.candidates,
  }) : super.withParent(
          parent: parent,
          topLeft: parent.topLeft,
          topRight: parent.topRight,
          bottomLeft: parent.bottomLeft,
          bottomRight: parent.bottomRight,
        );

  factory VisionRecognizedTextObservation.fromMap(Map<String, dynamic> map) {
    final candidates = map['candidates'] as List<Object?>?;
    if (candidates == null) {
      throw Exception('Failed to parse VisionRecognizedText');
    }
    return VisionRecognizedTextObservation.withParent(
      parent: VisionRectangleObservation.fromMap(map),
      candidates: [
        for (final data in candidates)
          if (data != null)
            VisionRecognizedTextCandidate.fromMap((data as Map).castEx()),
      ],
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

  factory VisionRecognizedTextCandidate.fromMap(Map<String, dynamic> map) {
    final str = map['string'] as String?;
    final confidence = map['confidence'] as double?;

    if (str == null || confidence == null) {
      throw Exception('Failed to parse VisionRecognizedTextCandidate');
    }

    return VisionRecognizedTextCandidate(
      text: str,
      confidence: confidence,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'confidence': confidence,
    };
  }
}
