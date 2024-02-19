import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';
import 'vision_rectangle_observation.dart';

extension VisionBarcodeObservationEx on VisionBarcodeObservation {
  Widget build() => customPaint(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionBarcodeObservation barcode;

  _Painter(this.barcode);

  @override
  void paint(Canvas canvas, Size size) {
    barcode.drawRect(canvas: canvas, size: size);
    final text = barcode.payloadStringValue;
    barcode.drawText(text: text ?? "", canvas: canvas, size: size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
