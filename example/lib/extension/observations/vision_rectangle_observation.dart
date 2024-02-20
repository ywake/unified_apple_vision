import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';

extension VisionRectangleEx on VisionRectangleObservation {
  void drawRect({
    required Canvas canvas,
    required Size size,
    Color color = Colors.black,
  }) {
    final rect = scale(size);
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
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
    final scaledRect = scale(size);
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
    textPainter.paint(canvas, scaledRect.topLeft);
  }

  Widget build() => customPaint(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionRectangleObservation rectangle;

  _Painter(this.rectangle);

  @override
  void paint(Canvas canvas, Size size) {
    rectangle.drawRect(canvas: canvas, size: size, color: Colors.green);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
