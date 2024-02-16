import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

extension VisionDetectedObjectObservationEx on VisionDetectedObjectObservation {
  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ObjectPainter(this),
      ),
    );
  }
}

class _ObjectPainter extends CustomPainter {
  final VisionDetectedObjectObservation object;

  _ObjectPainter(this.object);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = object.boundingBox;
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
