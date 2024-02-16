import Vision

@available(iOS 11.0, macOS 10.13, *)
class DetectRectanglesResults: AnalyzeResults {
  let observations: [VNRectangleObservation]

  init(_ observations: [VNRectangleObservation]) {
    self.observations = observations
  }

  func type() -> RequestType {
    return .detectRectangles
  }

  func toDict() -> [[String: Any]] {
    return self.observations.map { observation in
      return observation.toDict()
    }
  }
}
