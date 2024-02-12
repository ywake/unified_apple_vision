import Vision

enum TextRecognitionLevel: String {
  case fast = "fast"
  case accurate = "accurate"

  init(_ rawValue: String) {
    switch rawValue {
    case "fast": self = .fast
    case "accurate": self = .accurate
    default: self = .accurate
    }
  }

  func toVNRequestRecognitionLevel() -> VNRequestTextRecognitionLevel {
    switch self {
    case .fast: return .fast
    case .accurate: return .accurate
    }
  }
}
