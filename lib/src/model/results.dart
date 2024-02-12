import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/model/input_image.dart';

import 'recognized_text.dart';

class VisionResults {
  final VisionInputImage inputImage;
  final List<VisionRecognizedText>? recognizedTexts;

  VisionResults({
    required this.inputImage,
    this.recognizedTexts,
  });

  factory VisionResults.fromMap(VisionInputImage image, Map<String, dynamic> map) {
    final recognizedTexts = map['recognize_text_results'] as List?;

    return VisionResults(
      inputImage: image,
      recognizedTexts: _parseRecognizedTexts([
        if (recognizedTexts != null)
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
