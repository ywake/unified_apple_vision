import 'dart:ui';

import 'map.dart';
import 'offset.dart';
import 'size.dart';

extension RectEx on Rect {
  static Rect fromMap(Map<String, dynamic> map) {
    final origin = map['origin'] as Map?;
    final sizeMap = map['size'] as Map?;

    if (origin == null || sizeMap == null) {
      throw Exception('Failed to parse Rect');
    }

    final topLeft = OffsetEx.fromMap(origin.castEx());
    final size = SizeEx.fromMap(sizeMap.castEx());
    final bottomRight =
        Offset(topLeft.dx + size.width, topLeft.dy + size.height);
    return Rect.fromPoints(topLeft, bottomRight);
  }

  Map<String, dynamic> toMap() {
    return {
      'origin': topLeft.toMap(),
      'size': size.toMap(),
    };
  }
}
