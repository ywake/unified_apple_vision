class VisionRecognizedText {
  const VisionRecognizedText();

  factory VisionRecognizedText.fromMap(Map<String, dynamic> map) {
    return const VisionRecognizedText(
        // text: map['text'],
        // confidence: map['confidence'],
        // topLeft: VisionPoint.fromMap(map['topLeft']),
        // topRight: VisionPoint.fromMap(map['topRight']),
        // bottomLeft: VisionPoint.fromMap(map['bottomLeft']),
        // bottomRight: VisionPoint.fromMap(map['bottomRight']),
        );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'text': text,
      // 'confidence': confidence,
      // 'topLeft': topLeft.toMap(),
      // 'topRight': topRight.toMap(),
      // 'bottomLeft': bottomLeft.toMap(),
      // 'bottomRight': bottomRight.toMap(),
    };
  }
}
