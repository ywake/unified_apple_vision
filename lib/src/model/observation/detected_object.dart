import 'dart:ui';

import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/extension/rect.dart';
import 'package:unified_apple_vision/src/model/request/object_tracking/track_object_request.dart';

import 'observation.dart';

/// An observation that provides the position and extent of an image feature that an image analysis request detects.
///
/// This class is the observation type that [VisionTrackObjectRequest] generates. It represents an object that the Vision request detects and tracks.
class VisionDetectedObjectObservation extends VisionObservation {
  final Rect boundingBox;

  VisionDetectedObjectObservation.withParent({
    required this.boundingBox,
    required VisionObservation parent,
  }) : super.clone(parent);

  VisionDetectedObjectObservation.clone(VisionDetectedObjectObservation other)
      : this.withParent(
          boundingBox: other.boundingBox,
          parent: other,
        );

  factory VisionDetectedObjectObservation.fromMap(Map<String, dynamic> map) {
    final boundingBox = map['bounding_box'] as Map?;
    if (boundingBox == null) {
      throw Exception('Failed to parse VisionDetectedObjectObservation');
    }
    return VisionDetectedObjectObservation.withParent(
      parent: VisionObservation.fromMap(map),
      boundingBox: RectEx.fromMap(boundingBox.castEx()),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'bounding_box': boundingBox.toMap(),
    };
  }

  @override
  VisionDetectedObjectObservation copyWith({
    Rect? boundingBox,
    String? uuid,
    double? confidence,
  }) {
    return VisionDetectedObjectObservation.withParent(
      boundingBox: boundingBox ?? this.boundingBox,
      parent: super.copyWith(
        uuid: uuid,
        confidence: confidence,
      ),
    );
  }
}
