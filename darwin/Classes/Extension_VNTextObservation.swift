import Vision

extension VNTextObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "character_boxes": self.characterBoxes?.map { (characterBox: VNRectangleObservation) in
        return characterBox.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
