import Vision

class DetectRectanglesRequest: AnalyzeRequest {
  let minAspectRatio: VNAspectRatio?
  let maxAspectRatio: VNAspectRatio?
  let quadratureTolerance: VNDegrees?
  let minSize: Float?
  let minConfidence: Float?
  let maxObservations: Int?

  init(
    minAspectRatio: VNAspectRatio?,
    maxAspectRatio: VNAspectRatio?,
    quadratureTolerance: VNDegrees?,
    minSize: Float?,
    minConfidence: Float?,
    maxObservations: Int?
  ) {
    self.minAspectRatio = minAspectRatio
    self.maxAspectRatio = maxAspectRatio
    self.quadratureTolerance = quadratureTolerance
    self.minSize = minSize
    self.minConfidence = minConfidence
    self.maxObservations = maxObservations
  }

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }
    self.init(
      minAspectRatio: arg["min_aspect_ratio"] as? VNAspectRatio,
      maxAspectRatio: arg["max_aspect_ratio"] as? VNAspectRatio,
      quadratureTolerance: arg["quadrature_tolerance"] as? VNDegrees,
      minSize: arg["min_size"] as? Float,
      minConfidence: arg["min_confidence"] as? Float,
      maxObservations: arg["max_observations"] as? Int
    )
  }

  func type() -> RequestType {
    return .detectRectangles
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.error(
        "DetectRectanglesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectRectanglesRequest
  {
    let request = VNDetectRectanglesRequest(completionHandler: handler)
    if let minAspectRatio = self.minAspectRatio {
      request.minimumAspectRatio = minAspectRatio
    }
    if let maxAspectRatio = self.maxAspectRatio {
      request.maximumAspectRatio = maxAspectRatio
    }
    if let quadratureTolerance = self.quadratureTolerance {
      request.quadratureTolerance = quadratureTolerance
    }
    if let minSize = self.minSize {
      request.minimumSize = minSize
    }
    if let minConfidence = self.minConfidence {
      request.minimumConfidence = minConfidence
    }
    if let maxObservations = self.maxObservations {
      request.maximumObservations = maxObservations
    }
    return request
  }

  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return DetectRectanglesResults(
        observations as! [VNRectangleObservation]
      )
    } else {
      Logger.error(
        "DetectRectanglesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeResults"
      )
      return nil
    }
  }
}
