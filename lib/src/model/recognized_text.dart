import 'package:flutter/services.dart';
import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/extension/offset.dart';

class VisionRecognizedTextCandidate {
  final String text;
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

class VisionRecognizedText {
  final List<VisionRecognizedTextCandidate> candidates;
  final Offset topLeft;
  final Offset topRight;
  final Offset bottomLeft;
  final Offset bottomRight;

  const VisionRecognizedText({
    required this.candidates,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  factory VisionRecognizedText.fromMap(Map<String, dynamic> map) {
    final candidates = map['candidates'] as List<Object?>;
    final bottomLeft = map['bottom_left'] as Map?;
    final bottomRight = map['bottom_right'] as Map?;
    final topLeft = map['top_left'] as Map?;
    final topRight = map['top_right'] as Map?;

    if (bottomLeft == null || bottomRight == null || topLeft == null || topRight == null) {
      throw Exception('Failed to parse VisionRecognizedText');
    }

    return VisionRecognizedText(
      candidates: [
        for (final data in candidates)
          if (data != null) VisionRecognizedTextCandidate.fromMap((data as Map).castEx()),
      ],
      topLeft: OffsetEx.fromMap(topLeft.castEx()),
      topRight: OffsetEx.fromMap(topRight.castEx()),
      bottomLeft: OffsetEx.fromMap(bottomLeft.castEx()),
      bottomRight: OffsetEx.fromMap(bottomRight.castEx()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'candidates': [for (final c in candidates) c.toMap()],
      'top_left': topLeft.toMap(),
      'top_right': topRight.toMap(),
      'bottom_left': bottomLeft.toMap(),
      'bottom_right': bottomRight.toMap(),
    };
  }
}
