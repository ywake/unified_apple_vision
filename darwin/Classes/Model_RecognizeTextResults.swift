import Vision

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
        "bottom_left": [
          "x": observation.bottomLeft.x,
          "y": observation.bottomLeft.y,
        ],
        "bottom_right": [
          "x": observation.bottomRight.x,
          "y": observation.bottomRight.y,
        ],
        "top_left": [
          "x": observation.topLeft.x,
          "y": observation.topLeft.y,
        ],
        "top_right": [
          "x": observation.topRight.x,
          "y": observation.topRight.y,
        ],
      ]
    }
  }
}
