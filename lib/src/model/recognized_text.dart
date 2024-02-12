import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/model/rectangle.dart';
import 'package:unified_apple_vision/src/option/recognize_text_option.dart';

class VisionRecognizedText {
  /// List of candidates for recognition results. The maximum number is specified by [VisionRecognizeTextOption.maxCandidates] in descending order of accuracy.
  final List<VisionRecognizedTextCandidate> candidates;

  /// The coordinates are normalized to the image size, with the top-left corner being (0.0, 0.0) and the bottom-right corner being (1.0, 1.0).
  final VisionRectangle rectangle;

  const VisionRecognizedText({
    required this.candidates,
    required this.rectangle,
  });

  factory VisionRecognizedText.fromMap(Map<String, dynamic> map) {
    final candidates = map['candidates'] as List<Object?>?;
    final rectangle = map['rectangle'] as Map?;

    if (candidates == null || rectangle == null) {
      throw Exception('Failed to parse VisionRecognizedText');
    }

    return VisionRecognizedText(
      rectangle: VisionRectangle.fromMap(rectangle.castEx()),
      candidates: [
        for (final data in candidates)
          if (data != null) VisionRecognizedTextCandidate.fromMap((data as Map).castEx()),
      ],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'candidates': [for (final c in candidates) c.toMap()],
      'rectangle': rectangle.toMap(),
    };
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
