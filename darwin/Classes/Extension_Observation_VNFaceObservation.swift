import Vision

@available(iOS 11.0, macOS 10.13, *)
extension VNFaceObservation {
  @objc override func toDict() -> [String: Any] {
    var optional: [String: Any] = [:]
    // if #available(iOS 12.0, macOS 10.14, *) {  // in docs
    if #available(iOS 15.0, macOS 12.0, *) {  // actual
      optional = [
        "roll": self.roll,
        "yaw": self.yaw,
        "pitch": self.pitch,
      ].merging(optional) { (old, _) in old }
    }
    if #available(iOS 13.0, macOS 10.15, *) {
      optional = [
        "face_capture_quality": self.faceCaptureQuality
      ].merging(optional) { (old, _) in old }
    }
    return [
      "landmarks": self.landmarks?.toDict()
    ].merging(optional) { (old, _) in old }
      .merging(super.toDict()) { (old, _) in old }
  }
}

@available(iOS 11.0, macOS 10.13, *)
extension VNFaceLandmarks {
  @objc func toDict() -> [String: Any] {
    return [
      "confidence": self.confidence
    ]
  }
}

@available(iOS 11.0, macOS 10.13, *)
extension VNFaceLandmarks2D {
  @objc override func toDict() -> [String: Any] {
    return [
      "all_points": self.allPoints?.toDict(),
      "face_contour": self.faceContour?.toDict(),
      "left_eye": self.leftEye?.toDict(),
      "right_eye": self.rightEye?.toDict(),
      "left_eyebrow": self.leftEyebrow?.toDict(),
      "right_eyebrow": self.rightEyebrow?.toDict(),
      "nose": self.nose?.toDict(),
      "nose_crest": self.noseCrest?.toDict(),
      "median_line": self.medianLine?.toDict(),
      "outer_lips": self.outerLips?.toDict(),
      "inner_lips": self.innerLips?.toDict(),
      "left_pupil": self.leftPupil?.toDict(),
      "right_pupil": self.rightPupil?.toDict(),
    ].merging(super.toDict()) { (old, _) in old }
  }
}

extension VNFaceLandmarkRegion {
  @objc func toDict() -> [String: Any] {
    return [
      "point_count": self.pointCount
    ]
  }

}

extension VNFaceLandmarkRegion2D {
  @objc override func toDict() -> [String: Any] {
    var optional: [String: Any] = [:]
    if #available(iOS 13.0, macOS 10.15, *) {
      [
        "precision_estimates_per_point": self.precisionEstimatesPerPoint?.map { $0 }
      ].merging(optional) { (old, _) in old }
    }
    if #available(iOS 16.0, macOS 13.0, *) {
      [
        "points_classification": self.pointsClassification.name()
      ].merging(optional) { (old, _) in old }
    }
    return [
      "normalized_points": self.normalizedPoints.map { $0.reversedY().toDict() }
    ].merging(optional) { (old, _) in old }
      .merging(super.toDict()) { (old, _) in old }
  }
}

@available(iOS 16.0, macOS 13.0, *)
extension VNPointsClassification {
  func name() -> String {
    switch self {
    case .closedPath: return "closedPath"
    case .openPath: return "openPath"
    case .disconnected: return "disconnected"
    }
  }
}
