import Vision

@available(iOS 11.0, macOS 10.13, *)
extension VNFaceObservation {
  @objc override func toDict() -> [String: Any] {
    var dict: [String: Any] = [
      "landmarks": self.landmarks?.toDict()
    ]
    // if #available(iOS 12.0, macOS 10.14, *) {  // in docs
    if #available(iOS 15.0, macOS 12.0, *) {  // actual
      dict += [
        "roll": self.roll,
        "yaw": self.yaw,
        "pitch": self.pitch,
      ]
    }
    if #available(iOS 13.0, macOS 10.15, *) {
      dict += [
        "face_capture_quality": self.faceCaptureQuality
      ]
    }
    return dict + super.toDict()
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
    ] + super.toDict()
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
    var dict: [String: Any] = [
      "normalized_points": self.normalizedPoints.map { $0.reversedY().toDict() }
    ]
    if #available(iOS 13.0, macOS 10.15, *) {
      dict += [
        "precision_estimates_per_point": self.precisionEstimatesPerPoint?.map { $0 }
      ]
    }
    if #available(iOS 16.0, macOS 13.0, *) {
      dict += [
        "points_classification": self.pointsClassification.name()
      ]
    }
    return dict + super.toDict()
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
