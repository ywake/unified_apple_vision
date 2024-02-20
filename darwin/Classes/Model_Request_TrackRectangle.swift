import Vision

class TrackRectangleRequest: AnalyzeRequest {
  let requestId: String
  let inputObservation: VNRectangleObservation
  let trackingLevel: VNRequestTrackingLevel?
  let isLastFrame: Bool?

  init(
    requestId: String,
    inputObservation: VNRectangleObservation,
    trackingLevel: VNRequestTrackingLevel?,
    isLastFrame: Bool?
  ) {
    self.requestId = requestId
    self.inputObservation = inputObservation
    self.trackingLevel = trackingLevel
    self.isLastFrame = isLastFrame
  }

  convenience init(json: Json) throws {
    let level = try json.strOr("tracking_level") ?? ""
    let input = try json.json("input")
    self.init(
      requestId: try json.str("request_id"),
      inputObservation: try VNRectangleObservation(dict: input.dictData),
      trackingLevel: VNRequestTrackingLevel(byName: level),
      isLastFrame: json.boolOr("is_last_frame")
    )
  }

  func type() -> RequestType {
    return .trackRectangle
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.error(
        "TrackRectangleRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNTrackRectangleRequest
  {
    var request = VNTrackRectangleRequest(
      rectangleObservation: self.inputObservation,
      completionHandler: handler
    )
    if let trackingLevel = self.trackingLevel {
      request.trackingLevel = trackingLevel
    }
    if let isLastFrame = self.isLastFrame {
      request.isLastFrame = isLastFrame
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.debug("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNRectangleObservation)?.toDict() ?? [:] }
  }
}
