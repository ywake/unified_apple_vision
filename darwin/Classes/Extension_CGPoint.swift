import Foundation

extension CGPoint {
  init?(dict: [String: Any]) {
    guard let x = dict["x"] as? CGFloat else { return nil }
    guard let y = dict["y"] as? CGFloat else { return nil }
    self.init(x: x, y: y)
  }

  func toDict() -> [String: Any] {
    return [
      "x": self.x,
      "y": self.y,
    ]
  }
}
