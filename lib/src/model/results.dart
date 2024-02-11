import 'recognized_text.dart';

class VisionResults {
  final List<VisionRecognizedText>? recognizedTexts;

  VisionResults({
    this.recognizedTexts,
  });

  factory VisionResults.fromMap(Map<String, dynamic> map) {
    return VisionResults(recognizedTexts: []);
  }

  Map<String, dynamic> toMap() {
    return {
      'recognizedTexts': recognizedTexts?.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
