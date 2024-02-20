import Vision

class DetectFaceLandmarksRequest: AnalyzeRequest {
  let requestId: String
  let constellation: VNRequestFaceLandmarksConstellation?

  init(
    requestId: String,
    constellation: VNRequestFaceLandmarksConstellation?
  ) {
    self.requestId = requestId
    self.constellation = constellation
  }

  convenience init(json: Json) throws {
    self.init(
      requestId: try json.str("request_id"),
      constellation: json.strOr("constellation").map {
        VNRequestFaceLandmarksConstellation(byName: $0)
      }
    )
  }

  func type() -> RequestType {
    return .detectFaceLandmarks
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.error(
        "DetectFaceLandmarksRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectFaceLandmarksRequest
  {
    let request = VNDetectFaceLandmarksRequest(completionHandler: handler)
    if let constellation = self.constellation {
      request.constellation = constellation
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.debug("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNFaceObservation)?.toDict() ?? [:] }
  }
}

extension VNRequestFaceLandmarksConstellation {
  init(byName name: String) {
    switch name {
    case "constellation65Points": self = .constellation65Points
    case "constellation76Points": self = .constellation76Points
    default: self = .constellationNotDefined
    }
  }
}
