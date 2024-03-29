import Vision

class DetectHumanRectanglesRequest: ImageBasedRequest, AnalyzeRequest {
  let upperBodyOnly: Bool?

  init(
    parent: ImageBasedRequest,
    upperBodyOnly: Bool?
  ) {
    self.upperBodyOnly = upperBodyOnly
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    self.init(
      parent: try ImageBasedRequest(json: json),
      upperBodyOnly: json.boolOr("upper_body_only")
    )
  }

  func type() -> RequestType {
    return .detectHumanRectangles
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "13.0", macOS: "10.15")
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
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
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
