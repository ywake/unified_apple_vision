import Vision

@available(iOS 11.0, macOS 10.13, *)
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
    // Convert the lower left origin to the upper left origin
    return [
      "bottom_left": self.bottomLeft.reversedY().toDict(),
      "bottom_right": self.bottomRight.reversedY().toDict(),
      "top_left": self.topLeft.reversedY().toDict(),
      "top_right": self.topRight.reversedY().toDict(),
    ] + super.toDict()
  }
}
