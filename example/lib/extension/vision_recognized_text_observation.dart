import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';
import 'vision_rectangle_observation.dart';

extension VisionRecognizedTextObservationEx on VisionRecognizedTextObservation {
  Widget build() => builder(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionRecognizedTextObservation recognizedText;

  _Painter(this.recognizedText);

  @override
  void paint(Canvas canvas, Size size) {
    recognizedText.drawRect(canvas: canvas, size: size, color: Colors.red);

    // Draw top-left corner
    final rect = recognizedText.scale(size).reverse(Offset(0, size.height));
    final cornerPaint = Paint()..style = PaintingStyle.fill;
    canvas.drawCircle(rect.topLeft, 3, cornerPaint..color = Colors.red);

    // Draw the text
    final candidate = recognizedText.candidates.first;
    final text = candidate.text;
    final confidence = candidate.confidence;
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$text (${confidence.toStringAsFixed(1)})',
        style: const TextStyle(fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, rect.topLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
