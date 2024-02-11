import 'package:flutter/services.dart';

extension OffsetEx on Offset {
  static Offset fromMap(Map<String, dynamic> map) {
    return Offset(
      map['x'] as double,
      map['y'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'x': dx,
      'y': dy,
    };
  }
}
