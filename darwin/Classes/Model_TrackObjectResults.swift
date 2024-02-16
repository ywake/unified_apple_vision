import Vision

@available(iOS 11.0, macOS 10.13, *)
class TrackObjectResults: AnalyzeResults {
  let observations: [VNDetectedObjectObservation]

  init(_ observations: [VNDetectedObjectObservation]) {
    self.observations = observations
  }

  func type() -> RequestType {
    return .trackObject
  }

  func toDict() -> [String: Any] {
    return [
      "observations": self.observations.map { observation in
        return observation.toDict()
      }
    ]
  }
}
