import Vision

class AnalyzeRequest {
  let type: AnalysisType

  init(type: AnalysisType) {
    self.type = type
  }

  func makeRequest(_ result: @escaping (AnalyzeResults?) -> Void) throws -> VNRequest {
    fatalError("This method must be overridden")
  }
}
