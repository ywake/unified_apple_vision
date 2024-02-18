import Vision

class DetectTextRectanglesRequest: AnalyzeRequest {
  let requestId: String
  let reportCharacterBoxes: Bool?

  init(
    requestId: String,
    reportCharacterBoxes: Bool?
  ) {
    self.requestId = requestId
    self.reportCharacterBoxes = reportCharacterBoxes
  }

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }
    guard let requestId = arg["request_id"] as? String else { return nil }
    self.init(
      requestId: requestId,
      reportCharacterBoxes: arg["reportCharacterBoxes"] as? Bool
    )
  }

  func type() -> RequestType {
    return .detectTextRectangles
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.error(
        "DetectTextRectanglesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectTextRectanglesRequest
  {
    let request = VNDetectTextRectanglesRequest(completionHandler: handler)
    if let reportCharacterBoxes = self.reportCharacterBoxes {
      request.reportCharacterBoxes = reportCharacterBoxes
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    return result.map { ($0 as? VNTextObservation)?.toDict() ?? [:] }
  }
}
