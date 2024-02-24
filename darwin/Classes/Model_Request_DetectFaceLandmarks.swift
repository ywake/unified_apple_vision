import Vision

class DetectFaceLandmarksRequest: ImageBasedRequest, AnalyzeRequest {
  let constellation: VNRequestFaceLandmarksConstellation?

  init(
    parent: ImageBasedRequest,
    constellation: VNRequestFaceLandmarksConstellation?
  ) {
    self.constellation = constellation
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    self.init(
      parent: try ImageBasedRequest(json: json),
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

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "11.0", macOS: "10.13")
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
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
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
