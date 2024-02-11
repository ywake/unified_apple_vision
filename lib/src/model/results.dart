import 'package:unified_apple_vision/src/extension/map.dart';

import 'recognized_text.dart';

class VisionResults {
  final List<VisionRecognizedText>? recognizedTexts;

  VisionResults({
    this.recognizedTexts,
  });

  factory VisionResults.fromMap(Map<String, dynamic> map) {
    final recognizedTexts = map['recognize_text_results'] as List;

    return VisionResults(
      recognizedTexts: _parseRecognizedTexts([
        for (final data in recognizedTexts) (data as Map).castEx(),
      ]),
    );
  }

  static List<VisionRecognizedText>? _parseRecognizedTexts(
    List<Map<String, dynamic>> recognizedTexts,
  ) {
    return [
      for (final data in recognizedTexts) VisionRecognizedText.fromMap(data),
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'recognized_texts': [
        if (recognizedTexts != null)
          for (final text in recognizedTexts!) text.toMap(),
      ],
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
