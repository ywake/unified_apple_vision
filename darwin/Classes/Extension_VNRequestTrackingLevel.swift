import Vision

extension VNRequestTrackingLevel {
  init(byName name: String) {
    switch name {
    case "fast":
      self = .fast
    default:
      self = .accurate
    }
  }
}
