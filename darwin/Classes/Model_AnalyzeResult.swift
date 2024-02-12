@available(iOS 13.0, macOS 10.15, *)
class AnalyzeResults {
  var recognizeTextResults: RecognizeTextResults?

  func toData() -> [String: Any] {
    // The key must be defined in snake case.
    var data = [String: Any]()
    if let recognizeTextResults = self.recognizeTextResults {
      Logger.debug(
        "RecognizeTextResults: \(recognizeTextResults.toData())", "AnalyzeResults.toData"
      )
      data["recognize_text_results"] = recognizeTextResults.toData()
    }
    return data
  }
}
