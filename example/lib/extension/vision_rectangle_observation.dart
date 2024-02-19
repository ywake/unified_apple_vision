import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';

extension VisionRectangleEx on VisionRectangleObservation {
  VisionRectangleObservation reverse(Offset offset) {
    abs(Offset offset) => Offset(offset.dx.abs(), offset.dy.abs());

    return copyWith(
      topLeft: abs(offset - topLeft),
      topRight: abs(offset - topRight),
      bottomLeft: abs(offset - bottomLeft),
      bottomRight: abs(offset - bottomRight),
    );
  }

  void drawRect({
    required Canvas canvas,
    required Size size,
    Color color = Colors.black,
  }) {
    final rect = scale(size).reverse(Offset(0, size.height));
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

  Widget build() => builder(_Painter(this));
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
