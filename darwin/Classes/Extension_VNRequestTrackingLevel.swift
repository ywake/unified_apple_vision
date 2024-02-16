import Vision

extension VNRequestTrackingLevel {
  init?(_ value: String?) {
    switch value {
    case "fast":
      self = .fast
    case "accurate":
      self = .accurate
    default:
      return nil
    }
  }
}
