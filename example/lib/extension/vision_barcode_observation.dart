import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';
import 'vision_rectangle_observation.dart';

extension VisionBarcodeObservationEx on VisionBarcodeObservation {
  Widget build() => builder(_Painter(this));
}

class _Painter extends CustomPainter {
  final VisionBarcodeObservation barcode;

  _Painter(this.barcode);

  @override
  void paint(Canvas canvas, Size size) {
    barcode.drawRect(canvas: canvas, size: size);

    // Draw the text
    final rect = barcode.scale(size).reverse(Offset(0, size.height));
    final text = barcode.payloadStringValue;
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, rect.topLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
