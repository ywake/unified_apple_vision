import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:unified_apple_vision_example/extension/vision_rectangle_observation.dart';

extension VisionRecognizedTextObservationEx on VisionRecognizedTextObservation {
  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _Painter(this),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final VisionRecognizedTextObservation recognizedText;

  _Painter(this.recognizedText);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the bounding box
    final rect = recognizedText.scale(size).reverse(Offset(0, size.height));
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);

    // Draw top-left corner
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
