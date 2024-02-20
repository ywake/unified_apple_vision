import 'package:unified_apple_vision/src/utility/json.dart';

import 'detected_object.dart';

/// An object that represents a person that the request detects.
class VisionHumanObservation extends VisionDetectedObjectObservation {
  /// **iOS 15.0+, macOS 12.0+**
  ///
  /// A Boolean value that indicates whether the observation represents an upper-body or full-body rectangle.
  final bool? upperBodyOnly;

  VisionHumanObservation.withParent({
    required VisionDetectedObjectObservation parent,
    required this.upperBodyOnly,
  }) : super.clone(parent);

  VisionHumanObservation.clone(VisionHumanObservation other)
      : this.withParent(
          parent: other,
          upperBodyOnly: other.upperBodyOnly,
        );

  factory VisionHumanObservation.fromJson(Json json) {
    return VisionHumanObservation.withParent(
      parent: VisionDetectedObjectObservation.fromJson(json),
      upperBodyOnly: json.boolOr('upper_body_only'),
    );
  }
}
