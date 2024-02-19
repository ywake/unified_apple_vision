import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';
import 'vision_rectangle_observation.dart';

extension VisionTextObservationEx on VisionTextObservation {
  Widget build() => builder(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionTextObservation text;

  _Painter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    text.drawRect(canvas: canvas, size: size, color: Colors.red);
    if (text.characterBoxes == null) return;
    for (final charaBox in text.characterBoxes!) {
      charaBox.drawRect(canvas: canvas, size: size, color: Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
