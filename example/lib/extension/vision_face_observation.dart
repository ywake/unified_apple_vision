import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:unified_apple_vision_example/extension/vision_detected_object_observation.dart';

import 'vision_observation.dart';

extension VisionFaceLandmarkRegion2DEx on VisionFaceLandmarkRegion2D {
  void drawRegion({
    required Canvas canvas,
    required Rect scaledBoundingBox,
    Color color = Colors.black,
  }) {
    if (normalizedPoints.isEmpty) return;
    final firstPoint = toImagePoint(normalizedPoints.first, scaledBoundingBox);
    final path = Path()..moveTo(firstPoint.dx, firstPoint.dy);
    for (final point in normalizedPoints.sublist(1)) {
      final imagePoint = toImagePoint(point, scaledBoundingBox);
      path.lineTo(imagePoint.dx, imagePoint.dy);
    }
    path.lineTo(firstPoint.dx, firstPoint.dy);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  Offset toImagePoint(Offset point, Rect scaledBoundingBox) {
    final scaledPoint = point.scale(
        scaledBoundingBox.size.width, scaledBoundingBox.size.height);
    return scaledPoint + scaledBoundingBox.topLeft;
  }
}

extension VisionFaceObservationEx on VisionFaceObservation {
  Widget build() => customPaint(_Painter(this));

  void drawFaceLandmarks({
    required Canvas canvas,
    required Size size,
    Color color = Colors.black,
  }) {
    final scaledBox = scaledBoundingBox(size);
    drawRegion(VisionFaceLandmarkRegion2D? region) {
      region?.drawRegion(
        canvas: canvas,
        scaledBoundingBox: scaledBox,
        color: color,
      );
    }

    drawRegion(landmarks?.faceContour);
    drawRegion(landmarks?.leftEye);
    drawRegion(landmarks?.rightEye);
    drawRegion(landmarks?.leftEyebrow);
    drawRegion(landmarks?.rightEyebrow);
    drawRegion(landmarks?.nose);
    drawRegion(landmarks?.noseCrest);
    drawRegion(landmarks?.medianLine);
    drawRegion(landmarks?.outerLips);
    drawRegion(landmarks?.innerLips);
    drawRegion(landmarks?.leftPupil);
    drawRegion(landmarks?.rightPupil);
  }
}

class _Painter extends CustomPainter {
  final VisionFaceObservation observation;

  _Painter(this.observation);

  @override
  void paint(Canvas canvas, Size size) {
    observation.drawBoundingBox(canvas: canvas, size: size);
    observation.drawText(
      text: '${observation.confidence}',
      canvas: canvas,
      size: size,
    );
    observation.drawFaceLandmarks(canvas: canvas, size: size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
