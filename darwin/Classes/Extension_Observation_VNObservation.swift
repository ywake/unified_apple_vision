import Vision

@available(iOS 11.0, macOS 10.13, *)
extension VNObservation {
  @objc func toDict() -> [String: Any] {
    return [
      "uuid": self.uuid.uuidString,
      "confidence": self.confidence,
    ]
  }
}
