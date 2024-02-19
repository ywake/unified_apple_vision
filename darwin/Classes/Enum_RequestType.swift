enum RequestType: String {
  case recognizeText = "recognize_text"
  case detectRectangles = "detect_rectangles"
  case trackObject = "track_object"
  case trackRectangle = "track_rectangle"
  case recognizeAnimals = "recognize_animals"
  case detectTextRectangles = "detect_text_rectangles"
  case detectBarcodes = "detect_barcodes"
  case detectHumanRectangles = "detect_human_rectangles"

  init?(_ string: String) {
    self.init(rawValue: string)
  }

  func jsonToRequest(_ json: Json) throws -> AnalyzeRequest {
    switch self {
    case .recognizeText:
      return try RecognizeTextRequest(json: json)
    case .detectRectangles:
      return try DetectRectanglesRequest(json: json)
    case .trackObject:
      return try TrackObjectRequest(json: json)
    case .trackRectangle:
      return try TrackRectangleRequest(json: json)
    case .recognizeAnimals:
      return try RecognizeAnimalsRequest(json: json)
    case .detectTextRectangles:
      return try DetectTextRectanglesRequest(json: json)
    case .detectBarcodes:
      return try DetectBarcodesRequest(json: json)
    case .detectHumanRectangles:
      return try DetectHumanRectanglesRequest(json: json)
    }
  }
}
