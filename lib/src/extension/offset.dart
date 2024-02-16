import 'package:flutter/services.dart';

extension OffsetEx on Offset {
  static Offset fromMap(Map<String, dynamic> map) {
    final x = map['x'] as double?;
    final y = map['y'] as double?;

    if (x == null || y == null) {
      throw Exception('Failed to parse Offset');
    }

    return Offset(x, y);
  }

  Map<String, dynamic> toMap() {
    return {
      'x': dx,
      'y': dy,
    };
  }
}
