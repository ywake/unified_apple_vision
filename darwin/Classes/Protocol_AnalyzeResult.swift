protocol AnalyzeResults {
  func type() -> RequestType
  func toDict() -> [String: Any]
}
