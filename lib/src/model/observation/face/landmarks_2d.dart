import 'package:unified_apple_vision/src/utility/json.dart';

import 'landmark_region_2d.dart';

/// A collection of facial features that a request detects.
///
/// This class represents the set of all detectable 2D face landmarks and regions, exposed as properties. The coordinates of the face landmarks are normalized to the dimensions of the face observation’s boundingBox, with the origin at the bounding box’s upper-left corner. Use the VNImagePointForFaceLandmarkPoint(_:_:_:_:) function to convert normalized face landmark points into absolute points within the image’s coordinate system.
class VisionFaceLandmarks2D extends VisionFaceLandmarks {
  /// The region containing all face landmark points.
  final VisionFaceLandmarkRegion2D? allPoints;

  /// The region containing points that trace the face contour from the left cheek, over the chin, to the right cheek.
  final VisionFaceLandmarkRegion2D? faceContour;

  /// The region containing points that outline the left eye.
  final VisionFaceLandmarkRegion2D? leftEye;

  /// The region containing points that outline the right eye.
  final VisionFaceLandmarkRegion2D? rightEye;

  /// The region containing points that trace the left eyebrow.
  final VisionFaceLandmarkRegion2D? leftEyebrow;

  /// The region containing points that trace the right eyebrow.
  final VisionFaceLandmarkRegion2D? rightEyebrow;

  /// The region containing points that outline the nose.
  final VisionFaceLandmarkRegion2D? nose;

  /// The region containing points that trace the center crest of the nose.
  final VisionFaceLandmarkRegion2D? noseCrest;

  /// The region containing points that trace a vertical line down the center of the face.
  final VisionFaceLandmarkRegion2D? medianLine;

  /// The region containing points that outline the outside of the lips.
  final VisionFaceLandmarkRegion2D? outerLips;

  /// The region containing points that outline the space between the lips.
  final VisionFaceLandmarkRegion2D? innerLips;

  /// The region containing the point where the left pupil is located.
  final VisionFaceLandmarkRegion2D? leftPupil;

  /// The region containing the point where the right pupil is located.
  final VisionFaceLandmarkRegion2D? rightPupil;

  VisionFaceLandmarks2D.withParent({
    required VisionFaceLandmarks parent,
    this.allPoints,
    this.faceContour,
    this.leftEye,
    this.rightEye,
    this.leftEyebrow,
    this.rightEyebrow,
    this.nose,
    this.noseCrest,
    this.medianLine,
    this.outerLips,
    this.innerLips,
    this.leftPupil,
    this.rightPupil,
  }) : super.clone(parent);

  factory VisionFaceLandmarks2D.fromJson(Json json) {
    VisionFaceLandmarkRegion2D? getRegion(String key) =>
        json.objOr(key, VisionFaceLandmarkRegion2D.fromJson);
    return VisionFaceLandmarks2D.withParent(
      parent: VisionFaceLandmarks.fromJson(json),
      allPoints: getRegion('all_points'),
      faceContour: getRegion('face_contour'),
      leftEye: getRegion('left_eye'),
      rightEye: getRegion('right_eye'),
      leftEyebrow: getRegion('left_eyebrow'),
      rightEyebrow: getRegion('right_eyebrow'),
      nose: getRegion('nose'),
      noseCrest: getRegion('nose_crest'),
      medianLine: getRegion('median_line'),
      outerLips: getRegion('outer_lips'),
      innerLips: getRegion('inner_lips'),
      leftPupil: getRegion('left_pupil'),
      rightPupil: getRegion('right_pupil'),
    );
  }
}

/// The superclass for containers of face landmark information.
class VisionFaceLandmarks {
  final double confidence;
  VisionFaceLandmarks({
    required this.confidence,
  });

  VisionFaceLandmarks.clone(VisionFaceLandmarks other)
      : this(confidence: other.confidence);

  factory VisionFaceLandmarks.fromJson(Json json) {
    return VisionFaceLandmarks(
      confidence: json.double_('confidence'),
    );
  }
}
