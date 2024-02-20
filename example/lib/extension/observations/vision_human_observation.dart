import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_detected_object_observation.dart';
import 'vision_observation.dart';

extension VisionHumanObservationEx on VisionHumanObservation {
  Widget build() => customPaint(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionHumanObservation observation;

  _Painter(this.observation);

  @override
  void paint(Canvas canvas, Size size) {
    observation.drawBoundingBox(canvas: canvas, size: size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
