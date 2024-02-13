class AnalyzeResults {
  let type: AnalysisType

  init(type: AnalysisType) {
    self.type = type
  }

  func toData() -> [String: Any] {
    fatalError("This method must be overridden")
  }
}
