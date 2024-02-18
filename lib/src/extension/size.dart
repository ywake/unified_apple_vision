import 'dart:ui';

import 'package:unified_apple_vision/src/utility/json.dart';

extension SizeEx on Size {
  static Size fromJson(Json json) {
    return Size(
      json.double_('width'),
      json.double_('height'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
    };
  }
}
