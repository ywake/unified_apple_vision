import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_detected_object_observation.dart';
import 'vision_observation.dart';

extension VisionRecognizedObjectObservationEx
    on VisionRecognizedObjectObservation {
  Widget build() => customPaint(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionRecognizedObjectObservation object;

  _Painter(this.object);

  @override
  void paint(Canvas canvas, Size size) {
    object.drawBoundingBox(canvas: canvas, size: size, color: Colors.amber);
    // Draw the text
    final candidate = object.labels.firstOrNull;
    if (candidate == null) {
      return;
    }
    final text = candidate.identifier;
    final confidence = candidate.confidence;
    object.drawText(
      text: '$text (${confidence.toStringAsFixed(1)})',
      canvas: canvas,
      size: size,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
