protocol AnalyzeResults {
  func type() -> AnalysisType
  func toData() -> [String: Any]
}
