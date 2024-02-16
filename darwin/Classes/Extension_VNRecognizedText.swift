import Vision

extension VNRecognizedText {
  @objc func toDict() -> [String: Any] {
    return [
      "string": self.string,
      "confidence": self.confidence,
    ]
  }
}
