import Vision

extension VNRecognizedTextObservation {
  @objc func toDict(_ maxCandidates: Int) -> [String: Any] {
    return [
      "candidates": self.topCandidates(maxCandidates).map { (candidate: VNRecognizedText) in
        return candidate.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
