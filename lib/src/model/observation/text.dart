import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/model/request/detect_text_rectangles.dart';

import 'rectangle.dart';

/// Information about regions of text that an image analysis request detects.
///
/// This type of observation results from a [VisionDetectTextRectanglesRequest]. It expresses the location of each detected character by its bounding box.
class VisionTextObservation extends VisionRectangleObservation {
  /// An array of detected individual character bounding boxes.
  ///
  /// If the associated [VisionDetectTextRectanglesRequest] request indicates interest in character boxes by setting the option reportCharacterBoxes to true, this property is non-null. If no characters are found, it remains empty.
  final List<VisionRectangleObservation>? characterBoxes;

  VisionTextObservation.withParent({
    required VisionRectangleObservation parent,
    required this.characterBoxes,
  }) : super.clone(parent);

  VisionTextObservation.clone(VisionTextObservation other)
      : this.withParent(
          parent: other,
          characterBoxes: other.characterBoxes,
        );

  factory VisionTextObservation.fromMap(Map<String, dynamic> map) {
    final characterBoxes = (map['characterBoxes'] as List?)?.cast<Map>();

    return VisionTextObservation.withParent(
      parent: VisionRectangleObservation.fromMap(map),
      characterBoxes: characterBoxes == null
          ? null
          : [
              for (final characterBox in characterBoxes)
                VisionRectangleObservation.fromMap(characterBox.castEx()),
            ],
    );
  }
}
