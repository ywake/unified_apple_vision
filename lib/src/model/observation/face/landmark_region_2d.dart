import 'dart:ui';

import 'package:unified_apple_vision/src/extension/offset.dart';
import 'package:unified_apple_vision/src/utility/json.dart';

/// 2D geometry information for a specific facial feature.
///
/// This class represents the set of all facial landmark regions in 2D, exposed as properties.
class VisionFaceLandmarkRegion2D extends VisionFaceLandmarkRegion {
  /// **iOS 16.0+, macOS 13.0+**
  /// An enumeration that describes how to interpret the points the region provides.
  final VisionPointsClassification? pointsClassification;

  /// The array of normalized landmark points.
  final List<Offset> normalizedPoints;

  /// **iOS 13.0+, macOS 10.15+**
  /// Requests an array of precision estimates for each landmark point.
  final List<double>? precisionEstimatesPerPoint;

  VisionFaceLandmarkRegion2D.withParent({
    required VisionFaceLandmarkRegion parent,
    required this.pointsClassification,
    required this.normalizedPoints,
    this.precisionEstimatesPerPoint,
  }) : super.clone(parent);

  factory VisionFaceLandmarkRegion2D.fromJson(Json json) {
    return VisionFaceLandmarkRegion2D.withParent(
      parent: VisionFaceLandmarkRegion.fromJson(json),
      pointsClassification: json.enumOr(
        'points_classification',
        VisionPointsClassification.values,
      ),
      normalizedPoints: json.objList('normalized_points', OffsetEx.fromJsonRev),
      precisionEstimatesPerPoint: json.listOr<double>(
        'precision_estimates_per_point',
      ),
    );
  }
}

/// **iOS 16.0+, macOS 13.0**
///
/// The set of classifications that describe how to interpret the points the region provides.
enum VisionPointsClassification {
  closedPath,
  disconnected,
  openPath,
  ;
}

/// The superclass for information about a specific face landmark.
class VisionFaceLandmarkRegion {
  final int pointCount;
  const VisionFaceLandmarkRegion({required this.pointCount});

  VisionFaceLandmarkRegion.clone(VisionFaceLandmarkRegion other)
      : this(pointCount: other.pointCount);

  factory VisionFaceLandmarkRegion.fromJson(Json json) {
    return VisionFaceLandmarkRegion(pointCount: json.int_('point_count'));
  }
}
