import Vision

class TrackRectangleRequest: AnalyzeRequest {
  let inputObservation: VNRectangleObservation
  let trackingLevel: VNRequestTrackingLevel?
  let isLastFrame: Bool?

  init(
    inputObservation: VNRectangleObservation,
    trackingLevel: VNRequestTrackingLevel?,
    isLastFrame: Bool?
  ) {
    self.inputObservation = inputObservation
    self.trackingLevel = trackingLevel
    self.isLastFrame = isLastFrame
  }

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }

    let input = arg["input"] as? [String: Any]
    guard let input = input else { return nil }

    let inputObservation = VNRectangleObservation(dict: input)
    guard let inputObservation = inputObservation else { return nil }

    let level = arg["tracking_level"] as? String
    self.init(
      inputObservation: inputObservation,
      trackingLevel: VNRequestTrackingLevel(level),
      isLastFrame: arg["is_last_frame"] as? Bool
    )
  }

  func type() -> RequestType {
    return .trackRectangle
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

  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return TrackRectangleResults(observations as! [VNRectangleObservation])
    } else {
      Logger.error(
        "TrackRectangleRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeResults"
      )
      return nil
    }
  }
}
