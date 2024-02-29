import Vision

protocol AnalyzeRequest {
  func type() -> RequestType
  func id() -> String
  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest
  func encodeResult(_ result: [VNObservation]) -> [[String: Any]]
}

extension AnalyzeRequest {
  func getResults(_ req: VNRequest, _ err: Error?) throws -> [[String: Any]] {
    let funcName = "\(self.type().rawValue)>getResults"
    Logger.d("Request completed: \(self.type())", funcName)

    var error: PluginError?
    if let err = err {
      error = PluginError.analyzeRequestError(msg: err.localizedDescription)
    } else if req.results == nil {
      error = PluginError.resultsNotFound(self)
    }
    if let error = error {
      throw error
    }

    Logger.d("Request results: \(req.results!)", funcName)
    return self.encodeResult(req.results!)
  }
}
