import 'dart:ui';

import 'package:unified_apple_vision/src/extension/rect.dart';
import 'package:unified_apple_vision/src/model/request/object_tracking/track_object_request.dart';
import 'package:unified_apple_vision/src/utility/json.dart';

import 'observation.dart';

/// An observation that provides the position and extent of an image feature that an image analysis request detects.
///
/// This class is the observation type that [VisionTrackObjectRequest] generates. It represents an object that the Vision request detects and tracks.
class VisionDetectedObjectObservation extends VisionObservation {
  /// The bounding box of the object that the request detects.
  ///
  /// The system normalizes the coordinates to the dimensions of the processed image, with the origin at the upper-left corner of the image.
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

  factory VisionDetectedObjectObservation.fromJson(Json json) {
    return VisionDetectedObjectObservation.withParent(
      parent: VisionObservation.fromJson(json),
      boundingBox: json.obj('bounding_box', RectEx.fromJson),
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

  Rect scaledBoundingBox(Size size) {
    return boundingBox.scale(size);
  }
}
