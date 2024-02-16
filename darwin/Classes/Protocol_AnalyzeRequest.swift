import Vision

protocol AnalyzeRequest {
  func type() -> RequestType
  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest?
  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults?
}

extension AnalyzeRequest {
  func onComplete(_ setResult: @escaping (AnalyzeResults) -> Void) -> VNRequestCompletionHandler {
    return { (req: VNRequest, err: Error?) in
      let funcName = "\(self.type().rawValue)>onComplete"

      let isGood = err == nil && req.results != nil
      if !isGood {
        Logger.error("Failed to analyze \(self.type) Request.", funcName)
        return
      }

      if let res = self.makeResults(req.results!) {
        setResult(res)
      } else {
        Logger.error("Failed to create \(self.type) Results.", funcName)
      }
    }
  }
}
