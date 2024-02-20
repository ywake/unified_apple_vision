import Vision

@available(iOS 13.0, macOS 10.15, *)
extension VNFeaturePrintObservation {
  @objc override func toDict() -> [String: Any] {
    return [
      "data": self.data.base64EncodedString(),
      "element_count": self.elementCount,
      "element_type": self.elementType.name(),
    ].merging(super.toDict()) { (old, _) in old }
  }
}

extension VNElementType {
  func name() -> String {
    switch self {
    case .unknown: return "unknown"
    case .float: return "float"
    case .double: return "double"
    }
  }
}
