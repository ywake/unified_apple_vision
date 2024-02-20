import Foundation

extension CGPoint {
  init?(dict: [String: Any]) {
    guard let x = dict["x"] as? CGFloat else { return nil }
    guard let y = dict["y"] as? CGFloat else { return nil }
    self.init(x: x, y: y)
  }

  init(json: Json) throws {
    let x = try json.float("x")
    let y = try json.float("y")
    self.init(x: CGFloat(x), y: CGFloat(y))
  }

  /// Convert the lower left origin to the upper left origin
  /// - Returns:
  func reversedY() -> CGPoint {
    return CGPoint(x: self.x, y: 1 - self.y)
  }

  func toDict() -> [String: Any] {
    return [
      "x": self.x,
      "y": self.y,
    ]
  }
}
