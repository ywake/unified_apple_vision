import Vision

class RecognizeAnimalsRequest: ImageBasedRequest, AnalyzeRequest {
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
    return .recognizeAnimals
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(handler)
    } else {
      Logger.e(
        "RecognizeAnimalsRequest requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNRecognizeAnimalsRequest
  {
    let request = VNRecognizeAnimalsRequest(completionHandler: handler)
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNRecognizedObjectObservation)?.toDict() ?? [:] }
  }
}
