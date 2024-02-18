import Vision

class RecognizeAnimalsRequest: AnalyzeRequest {
  let requestId: String

  init(requestId: String) {
    self.requestId = requestId
  }

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }
    guard let requestId = arg["request_id"] as? String else { return nil }
    self.init(requestId: requestId)
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
      Logger.error(
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
    return result.map { ($0 as? VNRecognizedObjectObservation)?.toDict() ?? [:] }
  }
}
