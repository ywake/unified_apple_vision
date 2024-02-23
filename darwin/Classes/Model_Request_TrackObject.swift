import Vision

class TrackObjectRequest: ImageBasedRequest, AnalyzeRequest {
  let inputObservation: VNDetectedObjectObservation
  let trackingLevel: VNRequestTrackingLevel?
  let isLastFrame: Bool?

  init(
    parent: ImageBasedRequest,
    inputObservation: VNDetectedObjectObservation,
    trackingLevel: VNRequestTrackingLevel?,
    isLastFrame: Bool?
  ) {
    self.inputObservation = inputObservation
    self.trackingLevel = trackingLevel
    self.isLastFrame = isLastFrame
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    let level = try json.strOr("tracking_level") ?? ""
    let input = try json.json("input")
    self.init(
      parent: try ImageBasedRequest(json: json),
      inputObservation: try VNDetectedObjectObservation(dict: input.dictData),
      trackingLevel: VNRequestTrackingLevel(byName: level),
      isLastFrame: json.boolOr("is_last_frame")
    )
  }

  func type() -> RequestType {
    return .trackObject
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.e(
        "TrackObjectRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNTrackObjectRequest
  {
    var request = VNTrackObjectRequest(
      detectedObjectObservation: self.inputObservation,
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
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNDetectedObjectObservation)?.toDict() ?? [:] }
  }
}
