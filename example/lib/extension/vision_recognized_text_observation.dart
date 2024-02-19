import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';
import 'vision_rectangle_observation.dart';

extension VisionRecognizedTextObservationEx on VisionRecognizedTextObservation {
  Widget build() => customPaint(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionRecognizedTextObservation recognizedText;

  _Painter(this.recognizedText);

  @override
  void paint(Canvas canvas, Size size) {
    recognizedText.drawRect(canvas: canvas, size: size, color: Colors.red);
    final candidate = recognizedText.candidates.first;
    recognizedText.drawText(
      text: '${candidate.text} (${candidate.confidence.toStringAsFixed(1)})',
      canvas: canvas,
      size: size,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
