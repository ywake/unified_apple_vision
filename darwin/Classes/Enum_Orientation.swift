import ImageIO

enum Orientation: String {
  case up = "up"
  case upMirrored = "upMirrored"
  case down = "down"
  case downMirrored = "downMirrored"
  case left = "left"
  case leftMirrored = "leftMirrored"
  case right = "right"
  case rightMirrored = "rightMirrored"

  init(_ rawValue: String) {
    switch rawValue {
    case "up": self = .up
    case "upMirrored": self = .upMirrored
    case "down": self = .down
    case "downMirrored": self = .downMirrored
    case "left": self = .left
    case "leftMirrored": self = .leftMirrored
    case "right": self = .right
    case "rightMirrored": self = .rightMirrored
    default: self = .down
    }
  }

  func toCGImagePropertyOrientation() -> CGImagePropertyOrientation {
    switch self {
    case .up: return .up
    case .upMirrored: return .upMirrored
    case .down: return .down
    case .downMirrored: return .downMirrored
    case .left: return .left
    case .leftMirrored: return .leftMirrored
    case .right: return .right
    case .rightMirrored: return .rightMirrored
    }
  }
}
