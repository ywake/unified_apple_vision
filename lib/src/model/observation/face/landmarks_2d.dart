import 'package:unified_apple_vision/src/utility/json.dart';

import 'landmark_region_2d.dart';

/// A collection of facial features that a request detects.
///
/// This class represents the set of all detectable 2D face landmarks and regions, exposed as properties. The coordinates of the face landmarks are normalized to the dimensions of the face observation’s boundingBox, with the origin at the bounding box’s lower-left corner. Use the VNImagePointForFaceLandmarkPoint(_:_:_:_:) function to convert normalized face landmark points into absolute points within the image’s coordinate system.
class VisionFaceLandmarks2D extends VisionFaceLandmarks {
  final VisionFaceLandmarkRegion2D? allPoints;
  final VisionFaceLandmarkRegion2D? faceContour;
  final VisionFaceLandmarkRegion2D? leftEye;
  final VisionFaceLandmarkRegion2D? rightEye;
  final VisionFaceLandmarkRegion2D? leftEyebrow;
  final VisionFaceLandmarkRegion2D? rightEyebrow;
  final VisionFaceLandmarkRegion2D? nose;
  final VisionFaceLandmarkRegion2D? noseCrest;
  final VisionFaceLandmarkRegion2D? medianLine;
  final VisionFaceLandmarkRegion2D? outerLips;
  final VisionFaceLandmarkRegion2D? innerLips;
  final VisionFaceLandmarkRegion2D? leftPupil;
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
