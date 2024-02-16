import Vision

class RecognizeAnimalsRequest: AnalyzeRequest {
  func type() -> RequestType {
    return .recognizeAnimals
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

  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults? {
    if #available(iOS 13.0, macOS 10.15, *) {
      return RecognizeAnimalsResults(
        observations as! [VNRecognizedObjectObservation]
      )
    } else {
      Logger.error(
        "RecognizeAnimalsRequest requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeResults"
      )
      return nil
    }
  }
}
