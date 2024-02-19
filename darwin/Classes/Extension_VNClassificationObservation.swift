import Vision

@available(iOS 11.0, macOS 10.13, *)
extension VNClassificationObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "identifier": self.identifier
    ].merging(super.toDict()) { (old, _) in old }
  }
}
