import Vision

@available(iOS 11.0, macOS 10.13, *)
class TrackRectangleResults: AnalyzeResults {
  let observations: [VNRectangleObservation]

  init(_ observations: [VNRectangleObservation]) {
    self.observations = observations
  }

  func type() -> RequestType {
    return .trackRectangle
  }

  func toDict() -> [[String: Any]] {
    return self.observations.map { observation in
      return observation.toDict()
    }
  }
}
