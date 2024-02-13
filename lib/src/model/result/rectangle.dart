import 'dart:ui';

import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/extension/offset.dart';

/// An object that represents the four vertices of a detected rectangle.
class VisionRectangle {
  /// The coordinates of the upper-left corner of the observation bounding box.
  final Offset topLeft;

  /// The coordinates of the upper-right corner of the observation bounding box.
  final Offset topRight;

  /// The coordinates of the lower-left corner of the observation bounding box.
  final Offset bottomLeft;

  /// The coordinates of the lower-right corner of the observation bounding box.
  final Offset bottomRight;

  const VisionRectangle({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  factory VisionRectangle.fromMap(Map<String, dynamic> map) {
    final bottomLeft = map['bottom_left'] as Map?;
    final bottomRight = map['bottom_right'] as Map?;
    final topLeft = map['top_left'] as Map?;
    final topRight = map['top_right'] as Map?;

    if (bottomLeft == null ||
        bottomRight == null ||
        topLeft == null ||
        topRight == null) {
      throw Exception('Failed to parse VisionRectangle');
    }

    return VisionRectangle(
      topLeft: OffsetEx.fromMap(topLeft.castEx()),
      topRight: OffsetEx.fromMap(topRight.castEx()),
      bottomLeft: OffsetEx.fromMap(bottomLeft.castEx()),
      bottomRight: OffsetEx.fromMap(bottomRight.castEx()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'top_left': topLeft.toMap(),
      'top_right': topRight.toMap(),
      'bottom_left': bottomLeft.toMap(),
      'bottom_right': bottomRight.toMap(),
    };
  }

  VisionRectangle scale(Size size) {
    return VisionRectangle(
      topLeft: topLeft.scale(size.width, size.height),
      topRight: topRight.scale(size.width, size.height),
      bottomLeft: bottomLeft.scale(size.width, size.height),
      bottomRight: bottomRight.scale(size.width, size.height),
    );
  }
}
