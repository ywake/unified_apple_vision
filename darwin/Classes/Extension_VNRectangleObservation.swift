import Vision

extension VNRectangleObservation {
  @objc convenience init(dict: [String: Any]) throws {
    let json = Json(dict)
    let bottomLeft = try json.json("bottom_left")
    let bottomRight = try json.json("bottom_right")
    let topLeft = try json.json("top_left")
    let topRight = try json.json("top_right")
    self.init(
      requestRevision: VNDetectRectanglesRequestRevision1,
      topLeft: try CGPoint(json: topLeft),
      bottomLeft: try CGPoint(json: bottomLeft),
      bottomRight: try CGPoint(json: bottomRight),
      topRight: try CGPoint(json: topRight)
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
