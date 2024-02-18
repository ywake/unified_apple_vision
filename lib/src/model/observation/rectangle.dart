import 'dart:ui';

import 'package:unified_apple_vision/src/extension/offset.dart';
import 'package:unified_apple_vision/src/utility/json.dart';

import 'detected_object.dart';

/// An object that represents the four vertices of a detected rectangle.
class VisionRectangleObservation extends VisionDetectedObjectObservation {
  /// The coordinates of the upper-left corner of the observation bounding box.
  final Offset topLeft;

  /// The coordinates of the upper-right corner of the observation bounding box.
  final Offset topRight;

  /// The coordinates of the lower-left corner of the observation bounding box.
  final Offset bottomLeft;

  /// The coordinates of the lower-right corner of the observation bounding box.
  final Offset bottomRight;

  VisionRectangleObservation.withParent({
    required VisionDetectedObjectObservation parent,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  }) : super.withParent(
          parent: parent,
          boundingBox: parent.boundingBox,
        );

  VisionRectangleObservation.clone(VisionRectangleObservation other)
      : this.withParent(
          parent: other,
          topLeft: other.topLeft,
          topRight: other.topRight,
          bottomLeft: other.bottomLeft,
          bottomRight: other.bottomRight,
        );

  factory VisionRectangleObservation.fromJson(Json json) {
    final bottomLeft = json.json('bottom_left');
    final bottomRight = json.json('bottom_right');
    final topLeft = json.json('top_left');
    final topRight = json.json('top_right');
    return VisionRectangleObservation.withParent(
      parent: VisionDetectedObjectObservation.fromJson(json),
      topLeft: OffsetEx.fromJson(topLeft),
      topRight: OffsetEx.fromJson(topRight),
      bottomLeft: OffsetEx.fromJson(bottomLeft),
      bottomRight: OffsetEx.fromJson(bottomRight),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'top_left': topLeft.toMap(),
      'top_right': topRight.toMap(),
      'bottom_left': bottomLeft.toMap(),
      'bottom_right': bottomRight.toMap(),
    };
  }

  @override
  VisionRectangleObservation copyWith({
    Offset? topLeft,
    Offset? topRight,
    Offset? bottomLeft,
    Offset? bottomRight,
    Rect? boundingBox,
    String? uuid,
    double? confidence,
  }) {
    return VisionRectangleObservation.withParent(
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      bottomRight: bottomRight ?? this.bottomRight,
      parent: super.copyWith(
        boundingBox: boundingBox,
        uuid: uuid,
        confidence: confidence,
      ),
    );
  }

  VisionRectangleObservation scale(Size size) {
    return copyWith(
      topLeft: topLeft.scale(size.width, size.height),
      topRight: topRight.scale(size.width, size.height),
      bottomLeft: bottomLeft.scale(size.width, size.height),
      bottomRight: bottomRight.scale(size.width, size.height),
    );
  }
}
