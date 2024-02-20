import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

extension VisionClassificationObservationEx
    on Iterable<VisionClassificationObservation> {
  Widget build(int displayCount) {
    if (displayCount < 1 || isEmpty) {
      return const SizedBox();
    }
    final filter = toList().sublist(0, displayCount);
    return Positioned.fill(
      bottom: 0,
      child: IgnorePointer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final o in filter)
              Text(
                '${o.identifier} (${o.confidence.toStringAsFixed(2)})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
          ],
        ),
      ),
    );
  }
}
