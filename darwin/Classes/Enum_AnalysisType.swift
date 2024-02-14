enum AnalysisType: String {
  case recognizeText = "recognize_text"

  init?(_ string: String) {
    self.init(rawValue: string)
  }

  func analysisRequest(_ map: [String: Any]) -> AnalyzeRequest? {
    switch self {
    case .recognizeText:
      return RecognizeTextRequest(map)
    }
  }
}
