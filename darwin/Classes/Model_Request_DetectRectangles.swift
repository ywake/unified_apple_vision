import Vision

class DetectRectanglesRequest: ImageBasedRequest, AnalyzeRequest {
  let minAspectRatio: VNAspectRatio?
  let maxAspectRatio: VNAspectRatio?
  let quadratureTolerance: VNDegrees?
  let minSize: Float?
  let minConfidence: Float?
  let maxObservations: Int?

  init(
    parent: ImageBasedRequest,
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
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    self.init(
      parent: try ImageBasedRequest(json: json),
      minAspectRatio: json.floatOr("min_aspect_ratio"),
      maxAspectRatio: json.floatOr("max_aspect_ratio"),
      quadratureTolerance: json.floatOr("quadrature_tolerance"),
      minSize: json.floatOr("min_size"),
      minConfidence: json.floatOr("min_confidence"),
      maxObservations: json.intOr("max_observations")
    )
  }

  func type() -> RequestType {
    return .detectRectangles
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "11.0", macOS: "10.13")
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

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNRectangleObservation)?.toDict() ?? [:] }
  }
}
