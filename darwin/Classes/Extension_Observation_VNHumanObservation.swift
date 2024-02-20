import Vision

@available(iOS 15.0, macOS 12.0, *)
extension VNHumanObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "upper_body_only": self.upperBodyOnly
    ].merging(super.toDict()) { (old, _) in old }
  }
}
