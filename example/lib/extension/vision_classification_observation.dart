import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';

extension VisionRecognizedObjectObservationEx
    on VisionRecognizedObjectObservation {
  Widget build() => builder(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionRecognizedObjectObservation object;

  _Painter(this.object);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      object.boundingBox.left * size.width,
      (1 - object.boundingBox.top) * size.height,
      object.boundingBox.right * size.width,
      (1 - object.boundingBox.bottom + object.boundingBox.height * 2) *
          size.height, // ???
    );
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);

    // Draw the text
    final candidate = object.labels.firstOrNull;
    if (candidate == null) {
      return;
    }
    final text = candidate.identifier;
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
