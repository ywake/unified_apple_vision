import 'dart:typed_data';
import 'dart:ui';

import 'package:unified_apple_vision/src/enum/image_orientation.dart';

class VisionInputImage {
  final Uint8List bytes;
  final Size size;
  VisionImageOrientation orientation;

  VisionInputImage({
    required this.bytes,
    required this.size,
    this.orientation = VisionImageOrientation.up,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': bytes,
      'width': size.width,
      'height': size.height,
      'orientation': orientation.name,
    };
  }
}
