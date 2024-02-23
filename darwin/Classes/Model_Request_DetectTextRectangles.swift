import Vision

class DetectTextRectanglesRequest: ImageBasedRequest, AnalyzeRequest {
  let reportCharacterBoxes: Bool?

  init(
    parent: ImageBasedRequest,
    reportCharacterBoxes: Bool?
  ) {
    self.reportCharacterBoxes = reportCharacterBoxes
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    self.init(
      parent: try ImageBasedRequest(json: json),
      reportCharacterBoxes: json.boolOr("reportCharacterBoxes")
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
      Logger.e(
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
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNTextObservation)?.toDict() ?? [:] }
  }
}
