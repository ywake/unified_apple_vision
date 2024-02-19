import Vision

@available(iOS 13.0, macOS 10.15, *)
extension VNRecognizedText {
  @objc func toDict() -> [String: Any] {
    return [
      "string": self.string,
      "confidence": self.confidence,
    ]
  }
}
