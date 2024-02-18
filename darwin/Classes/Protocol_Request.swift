import Vision

typealias OnResultHandler = ([String: Any]) -> Void

protocol AnalyzeRequest {
  func type() -> RequestType
  func id() -> String
  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest?
  func encodeResult(_ result: [VNObservation]) -> [[String: Any]]
}

extension AnalyzeRequest {
  func getCompletionHandler(_ onResult: @escaping OnResultHandler)
    -> VNRequestCompletionHandler
  {
    return { (req: VNRequest, err: Error?) in
      let funcName = "\(self.type().rawValue)>onResult"

      let isGood = err == nil && req.results != nil
      if !isGood {
        Logger.error("Failed to analyze \(self.type()) Request.", funcName)
        return
      }
      let res = [
        "request_id": self.id(),
        "results": self.encodeResult(req.results!),
      ]
      onResult(res)
    }
  }
}
