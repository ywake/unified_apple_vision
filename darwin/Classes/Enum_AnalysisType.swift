enum AnalysisType: String {
  case recognizeText = "recognize_text"

  func analysisRequest(_ map: [String: Any]) -> AnalyzeRequest? {
    switch self {
    case .recognizeText:
      return RecognizeTextRequest(map)
    }
  }
}
