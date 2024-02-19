import Vision

@available(iOS 12.0, macOS 10.14, *)
extension VNRecognizedObjectObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "labels": self.labels.map { (label: VNClassificationObservation) in
        return label.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
