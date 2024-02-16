import Vision

class DetectTextRectanglesRequest: AnalyzeRequest {
  let reportCharacterBoxes: Bool?

  init(
    reportCharacterBoxes: Bool?
  ) {
    self.reportCharacterBoxes = reportCharacterBoxes
  }

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }

    let reportCharacterBoxes = arg["reportCharacterBoxes"] as? Bool
    self.init(
      reportCharacterBoxes: reportCharacterBoxes
    )
  }

  func type() -> RequestType {
    return .detectTextRectangles
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

  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return DetectTextRectanglesResults(
        observations as! [VNTextObservation]
      )
    } else {
      Logger.error(
        "DetectTextRectanglesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeResults"
      )
      return nil
    }
  }
}
