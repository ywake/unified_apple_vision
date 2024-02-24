import Vision

class DetectFaceRectanglesRequest: ImageBasedRequest, AnalyzeRequest {
  init(
    parent: ImageBasedRequest
  ) {
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    self.init(
      parent: try ImageBasedRequest(json: json)
    )
  }

  func type() -> RequestType {
    return .detectFaceRectangles
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.e(
        "DetectFaceRectanglesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectFaceRectanglesRequest
  {
    let request = VNDetectFaceRectanglesRequest(completionHandler: handler)
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNFaceObservation)?.toDict() ?? [:] }
  }
}
