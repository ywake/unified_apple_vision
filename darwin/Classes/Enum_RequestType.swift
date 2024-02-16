enum RequestType: String {
  case recognizeText = "recognize_text"
  case trackObject = "track_object"
  case trackRectangle = "track_rectangle"

  init?(_ string: String) {
    self.init(rawValue: string)
  }

  func mapToRequest(_ map: [String: Any]) -> AnalyzeRequest? {
    switch self {
    case .recognizeText:
      return RecognizeTextRequest(map)
    case .trackObject:
      return TrackObjectRequest(map)
    case .trackRectangle:
      return TrackRectangleRequest(map)
    }
  }
}
