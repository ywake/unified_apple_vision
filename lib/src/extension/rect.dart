import 'dart:ui';

import 'package:unified_apple_vision/src/utility/json.dart';

import 'offset.dart';
import 'size.dart';

extension RectEx on Rect {
  /// Convert a json with lowerLeft origin to a Rect with upperLeft origin.
  static Rect fromJson(Json json) {
    final bottomLeft = json.obj('origin', OffsetEx.fromJsonRev);
    final size = json.obj('size', SizeEx.fromJson);
    final topLeft = bottomLeft - Offset(0, size.height);
    final bottomRight = bottomLeft + Offset(size.width, 0);
    return Rect.fromPoints(topLeft, bottomRight);
  }

  /// Convert a Rect with upperLeft origin to a json with lowerLeft origin.
  Map<String, dynamic> toMap() {
    return {
      'origin': bottomLeft.reverseY(1).toMap(),
      'size': size.toMap(),
    };
  }

  Rect scale(Size size) {
    return Rect.fromLTWH(
      left * size.width,
      top * size.height,
      width * size.width,
      height * size.height,
    );
  }
}
