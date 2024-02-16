import Vision

@available(iOS 13.0, macOS 10.15, *)
class RecognizeAnimalsResults: AnalyzeResults {
  let observations: [VNRecognizedObjectObservation]

  init(_ observations: [VNRecognizedObjectObservation]) {
    self.observations = observations
  }

  func type() -> RequestType {
    return .recognizeAnimals
  }

  func toDict() -> [[String: Any]] {
    return self.observations.map { observation in
      return observation.toDict()
    }
  }
}
