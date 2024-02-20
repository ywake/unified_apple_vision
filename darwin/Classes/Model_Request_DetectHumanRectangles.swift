import Vision

class DetectHumanRectanglesRequest: AnalyzeRequest {
  let requestId: String
  let upperBodyOnly: Bool?

  init(
    requestId: String,
    upperBodyOnly: Bool?
  ) {
    self.requestId = requestId
    self.upperBodyOnly = upperBodyOnly
  }

  convenience init(json: Json) throws {
    self.init(
      requestId: try json.str("request_id"),
      upperBodyOnly: json.boolOr("upper_body_only")
    )
  }

  func type() -> RequestType {
    return .detectHumanRectangles
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(handler)
    } else {
      Logger.error(
        "DetectHumanRectanglesRequest requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectHumanRectanglesRequest
  {
    let request = VNDetectHumanRectanglesRequest(completionHandler: handler)
    if #available(iOS 15.0, macOS 12.0, *) {
      if let upperBodyOnly = self.upperBodyOnly {
        request.upperBodyOnly = upperBodyOnly
      }
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.debug("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { observation in
      if #available(iOS 15.0, macOS 12.0, *) {
        return (observation as? VNHumanObservation)?.toDict() ?? [:]
      } else {
        // iOS 13.0 - 14.x, macOS 10.15 - 11.x
        // I couldn't figure out which Observation to use from the documentation,
        // so I'll just use VNDetectedObjectObservation temporarily.
        return (observation as? VNDetectedObjectObservation)?.toDict() ?? [:]
      }
    }
  }
}
