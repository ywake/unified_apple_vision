import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

extension VisionObservationEx on VisionObservation {
  @protected
  Widget builder(CustomPainter painter) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: painter,
        ),
      ),
    );
  }
}
