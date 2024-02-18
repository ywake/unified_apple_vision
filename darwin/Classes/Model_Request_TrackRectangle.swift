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

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }
    guard let requestId = arg["request_id"] as? String else { return nil }

    let input = arg["input"] as? [String: Any]
    guard let input = input else { return nil }

    let inputObservation = VNRectangleObservation(dict: input)
    guard let inputObservation = inputObservation else { return nil }

    let level = arg["tracking_level"] as? String
    self.init(
      requestId: requestId,
      inputObservation: inputObservation,
      trackingLevel: VNRequestTrackingLevel(level),
      isLastFrame: arg["is_last_frame"] as? Bool
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
