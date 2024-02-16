import Vision

extension VNRectangleObservation {
  @objc convenience init?(dict: [String: Any]?) {
    guard let dict = dict else { return nil }
    guard
      let bottomLeft = dict["bottom_left"] as? [String: CGFloat],
      let bottomRight = dict["bottom_right"] as? [String: CGFloat],
      let topLeft = dict["top_left"] as? [String: CGFloat],
      let topRight = dict["top_right"] as? [String: CGFloat]
    else { return nil }

    self.init(
      requestRevision: VNDetectRectanglesRequestRevision1,
      topLeft: CGPoint(x: topLeft["x"]!, y: topLeft["y"]!),
      bottomLeft: CGPoint(x: bottomLeft["x"]!, y: bottomLeft["y"]!),
      bottomRight: CGPoint(x: bottomRight["x"]!, y: bottomRight["y"]!),
      topRight: CGPoint(x: topRight["x"]!, y: topRight["y"]!)
    )
  }

  @objc override func toDict() -> [String: Any] {
    return [
      "bottom_left": self.bottomLeft.toDict(),
      "bottom_right": self.bottomRight.toDict(),
      "top_left": self.topLeft.toDict(),
      "top_right": self.topRight.toDict(),
    ].merging(super.toDict()) { (old, _) in old }
  }
}
