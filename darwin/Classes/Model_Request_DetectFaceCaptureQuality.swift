import Vision

class DetectFaceCaptureQualityRequest: AnalyzeRequest {
  let requestId: String

  init(
    requestId: String
  ) {
    self.requestId = requestId
  }

  convenience init(json: Json) throws {
    self.init(
      requestId: try json.str("request_id")
    )
  }

  func type() -> RequestType {
    return .detectFaceCaptureQuality
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(handler)
    } else {
      Logger.e(
        "DetectFaceCaptureQualityRequest requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectFaceCaptureQualityRequest
  {
    let request = VNDetectFaceCaptureQualityRequest(completionHandler: handler)
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNFaceObservation)?.toDict() ?? [:] }
  }
}
