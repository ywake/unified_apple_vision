import Vision

@available(iOS 13.0, macOS 10.15, *)
class RecognizeTextResults {
  let observations: [VNRecognizedTextObservation]
  let maxCandidates: Int

  init(_ observations: [VNRecognizedTextObservation], maxCandidates: Int?) {
    self.observations = observations
    self.maxCandidates = maxCandidates ?? 1
  }

  func toData() -> [[String: Any]] {
    return self.observations.map { observation in
      return [
        "candidates": observation.topCandidates(self.maxCandidates).map { candidate in
          return [
            "string": candidate.string,
            "confidence": candidate.confidence,
          ]
        },
        "rectangle": observation.toData(),
      ]
    }
  }
}
