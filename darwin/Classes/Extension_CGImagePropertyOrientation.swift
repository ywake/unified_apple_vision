extension CGImagePropertyOrientation {
  init(_ value: String) {
    switch value {
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
}
