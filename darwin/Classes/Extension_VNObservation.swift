import Vision

extension VNObservation {
  @objc func toDict() -> [String: Any] {
    return [
      "uuid": self.uuid.uuidString,
      "confidence": self.confidence,
    ]
  }
}
