import Vision

extension VNRecognizedText {
  func toDict() -> [String: Any] {
    return [
      "string": self.string,
      "confidence": self.confidence,
    ]
  }
}
