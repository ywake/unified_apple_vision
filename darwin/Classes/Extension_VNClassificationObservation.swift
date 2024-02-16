import Vision

extension VNClassificationObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "identifier": self.identifier
    ].merging(super.toDict()) { (old, _) in old }
  }
}
