import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';

extension VisionDetectedObjectObservationEx on VisionDetectedObjectObservation {
  void drawBoundingBox({
    required Canvas canvas,
    required Size size,
    Color color = Colors.black,
  }) {
    final boundingBox = scaledBoundingBox(size);
    final path = Path()
      ..moveTo(boundingBox.topLeft.dx, boundingBox.topLeft.dy)
      ..lineTo(boundingBox.topRight.dx, boundingBox.topRight.dy)
      ..lineTo(boundingBox.bottomRight.dx, boundingBox.bottomRight.dy)
      ..lineTo(boundingBox.bottomLeft.dx, boundingBox.bottomLeft.dy)
      ..lineTo(boundingBox.topLeft.dx, boundingBox.topLeft.dy);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  void drawText({
    required String text,
    required Canvas canvas,
    required Size size,
    Color color = Colors.white,
    TextStyle style = const TextStyle(fontSize: 10),
  }) {
    final boundingBox = scaledBoundingBox(size);
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style.copyWith(color: color),
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: size.width,
      );
    textPainter.paint(canvas, boundingBox.topLeft);
  }

  Widget build() => customPaint(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionDetectedObjectObservation object;

  _Painter(this.object);

  @override
  void paint(Canvas canvas, Size size) {
    object.drawBoundingBox(canvas: canvas, size: size, color: Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
