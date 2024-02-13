import 'package:unified_apple_vision/src/enum/analysis_type.dart';
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

  factory VisionResults.fromMap(
      VisionInputImage image, Map<String, dynamic> map) {
    final recognizedTexts = map[AnalysisType.recognizeText.key] as Map?;

    return VisionResults(
      inputImage: image,
      recognizedTexts: _parseRecognizedTexts(recognizedTexts?.castEx()),
    );
  }

  static List<VisionRecognizedText>? _parseRecognizedTexts(
      Map<String, dynamic>? recognizedTexts) {
    if (recognizedTexts == null) {
      return null;
    }
    final observations = recognizedTexts.castEx()["observations"] as List?;
    return observations?.map((data) {
      return VisionRecognizedText.fromMap((data as Map).castEx());
    }).toList();
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
