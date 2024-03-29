import Vision

@available(iOS 13.0, macOS 10.15, *)
extension VNRecognizedTextObservation {
  @available(*, unavailable)
  override func toDict() -> [String: Any] {
    fatalError("Don't call this method directly. Use toDict(_ maxCandidates: Int) instead.")
  }

  @objc func toDict(_ maxCandidates: Int) -> [String: Any] {
    return [
      "candidates": self.topCandidates(maxCandidates).map { (candidate: VNRecognizedText) in
        return candidate.toDict()
      }
    ] + super.toDict()
  }
}

@available(iOS 13.0, macOS 10.15, *)
extension VNRecognizedText {
  @objc func toDict() -> [String: Any] {
    return [
      "string": self.string,
      "confidence": self.confidence,
    ]
  }
}
