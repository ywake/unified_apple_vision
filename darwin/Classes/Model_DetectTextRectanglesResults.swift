import Vision

@available(iOS 11.0, macOS 10.13, *)
class DetectTextRectanglesResults: AnalyzeResults {
  let observations: [VNTextObservation]

  init(_ observations: [VNTextObservation]) {
    self.observations = observations
  }

  func type() -> RequestType {
    return .detectTextRectangles
  }

  func toDict() -> [[String: Any]] {
    return self.observations.map { observation in
      return observation.toDict()
    }
  }
}
