import Foundation

extension CGSize {
  init?(dict: [String: Any]) {
    guard let width = dict["width"] as? CGFloat else { return nil }
    guard let height = dict["height"] as? CGFloat else { return nil }
    self.init(width: width, height: height)
  }

  func toDict() -> [String: Any] {
    return [
      "width": self.width,
      "height": self.height,
    ]
  }
}
