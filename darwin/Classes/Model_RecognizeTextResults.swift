import Vision

@available(iOS 13.0, macOS 10.15, *)
class RecognizeTextResults: AnalyzeResults {
  let observations: [VNRecognizedTextObservation]
  let maxCandidates: Int

  init(_ observations: [VNRecognizedTextObservation], maxCandidates: Int?) {
    self.observations = observations
    self.maxCandidates = maxCandidates ?? 1
  }

  func type() -> RequestType {
    return .recognizeText
  }

  func toDict() -> [[String: Any]] {
    return self.observations.map { observation in
      return observation.toDict(self.maxCandidates)
    }
  }
}
