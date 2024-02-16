import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

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

  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _RectanglePainter(this),
      ),
    );
  }
}

class _RectanglePainter extends CustomPainter {
  final VisionRectangleObservation rectangle;

  _RectanglePainter(this.rectangle);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = rectangle.scale(size).reverse(Offset(0, size.height));
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
