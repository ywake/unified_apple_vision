import 'package:flutter/services.dart';
import 'package:unified_apple_vision/src/utility/json.dart';

extension OffsetEx on Offset {
  static Offset fromJson(Json json) {
    return Offset(
      json.double_('x'),
      json.double_('y'),
    );
  }

  static Offset fromJsonRev(Json json) {
    return fromJson(json).reverseY(1);
  }

  Offset reverseY(double height) {
    return Offset(dx, height - dy);
  }

  Map<String, dynamic> toMap() {
    return {
      'x': dx,
      'y': dy,
    };
  }
}
