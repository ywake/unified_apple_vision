import Vision

extension VNTextObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "characterBoxes": self.characterBoxes?.map { (characterBox: VNRectangleObservation) in
        return characterBox.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
