import Vision

extension VNRecognizedObjectObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "labels": self.labels.map { (label: VNClassificationObservation) in
        return label.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
