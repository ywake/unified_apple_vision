import 'dart:ui';

extension SizeEx on Size {
  static Size fromMap(Map<String, dynamic> map) {
    final width = map['width'] as double?;
    final height = map['height'] as double?;

    if (width == null || height == null) {
      throw Exception('Failed to parse Size');
    }

    return Size(width, height);
  }

  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
    };
  }
}
