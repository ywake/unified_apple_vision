import Vision

class TrackRectangleRequest: ImageBasedRequest, AnalyzeRequest {
  let inputObservation: VNRectangleObservation
  let trackingLevel: VNRequestTrackingLevel?
  let isLastFrame: Bool?

  init(
    parent: ImageBasedRequest,
    inputObservation: VNRectangleObservation,
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

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "11.0", macOS: "10.13")
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
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNRectangleObservation)?.toDict() ?? [:] }
  }
}
