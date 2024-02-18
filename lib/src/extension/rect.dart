import 'dart:ui';

import 'package:unified_apple_vision/src/utility/json.dart';

import 'offset.dart';
import 'size.dart';

extension RectEx on Rect {
  static Rect fromJson(Json json) {
    final origin = json.json('origin');
    final sizeJson = json.json('size');
    final topLeft = OffsetEx.fromJson(origin);
    final size = SizeEx.fromJson(sizeJson);
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
