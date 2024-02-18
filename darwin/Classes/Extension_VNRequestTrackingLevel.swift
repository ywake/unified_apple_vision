import Vision

extension VNRequestTrackingLevel {
  init(_ value: String?) {
    switch value {
    case "fast":
      self = .fast
    default:
      self = .accurate
    }
  }
}
