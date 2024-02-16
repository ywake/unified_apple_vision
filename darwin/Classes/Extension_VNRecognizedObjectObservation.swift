import Vision

extension VNRecognizedObjectObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "labels": self.labels.map { label in
        return label.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
