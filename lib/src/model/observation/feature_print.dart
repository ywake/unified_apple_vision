import 'dart:typed_data';

import 'package:unified_apple_vision/src/utility/json.dart';

import 'observation.dart';

/// An observation that provides the recognized feature print.
class VisionFeaturePrintObservation extends VisionObservation {
  // Fetching Feature Print Data

  /// The feature print data.
  ///
  /// The data is divided into separate elements. Determine the type of element using [elementType], and the number of elements using [elementCount].
  final Uint8List data;

  /// The total number of elements in the data.
  final int elementCount;

  // Determining Types of Feature Prints

  /// The type of each element in the data.
  final VisionElementType elementType;

  // Computing Distance Between Features

  /// Computes the distance between two feature print observations.
  ///
  /// Shorter distances indicate greater similarity between feature prints.
  double? computeDistance(VisionFeaturePrintObservation to) {
    throw UnimplementedError();
  }

  VisionFeaturePrintObservation.withParent({
    required VisionObservation parent,
    required this.data,
    required this.elementCount,
    required this.elementType,
  }) : super.clone(parent);

  VisionFeaturePrintObservation.clone(VisionFeaturePrintObservation other)
      : this.withParent(
          parent: other,
          data: other.data,
          elementCount: other.elementCount,
          elementType: other.elementType,
        );

  factory VisionFeaturePrintObservation.fromJson(Json json) {
    return VisionFeaturePrintObservation.withParent(
      parent: VisionObservation.fromJson(json),
      data: json.bytes('data'),
      elementCount: json.int_('element_count'),
      elementType: json.enum_('element_type', VisionElementType.values),
    );
  }
}

/// An enumeration of the type of element in feature print data.
enum VisionElementType {
  /// The element type isn't known.
  unknown,

  /// The elements are floating-point numbers.
  float,

  /// The elements are double-precision floating-point numbers.
  double,
}
