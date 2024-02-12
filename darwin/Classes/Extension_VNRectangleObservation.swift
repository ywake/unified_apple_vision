import Vision

extension VNRectangleObservation {
  func toData() -> [String: Any] {
    return [
      "bottom_left": [
        "x": self.bottomLeft.x,
        "y": self.bottomLeft.y,
      ],
      "bottom_right": [
        "x": self.bottomRight.x,
        "y": self.bottomRight.y,
      ],
      "top_left": [
        "x": self.topLeft.x,
        "y": self.topLeft.y,
      ],
      "top_right": [
        "x": self.topRight.x,
        "y": self.topRight.y,
      ],
    ]
  }
}
