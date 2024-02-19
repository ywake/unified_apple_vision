import Vision

@available(iOS 11.0, macOS 10.13, *)
extension VNTextObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "character_boxes": self.characterBoxes?.map { (characterBox: VNRectangleObservation) in
        return characterBox.toDict()
      }
    ].merging(super.toDict()) { (old, _) in old }
  }
}
