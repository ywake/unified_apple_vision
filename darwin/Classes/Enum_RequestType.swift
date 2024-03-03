enum RequestType: String {
  case recognizeText = "recognize_text"
  case detectRectangles = "detect_rectangles"
  case trackObject = "track_object"
  case trackRectangle = "track_rectangle"
  case recognizeAnimals = "recognize_animals"
  case detectTextRectangles = "detect_text_rectangles"
  case detectBarcodes = "detect_barcodes"
  case detectHumanRectangles = "detect_human_rectangles"
  case detectFaceRectangles = "detect_face_rectangles"
  case detectFaceLandmarks = "detect_face_landmarks"
  case detectFaceCaptureQuality = "detect_face_capture_quality"
  case classifyImage = "classify_image"
  case generateImageFeaturePrint = "generate_image_feature_print"
  case coreMlClassify = "core_ml_classify"
  case coreMlRecognize = "core_ml_recognize"

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
    case .detectFaceRectangles:
      return try DetectFaceRectanglesRequest(json: json)
    case .detectFaceLandmarks:
      return try DetectFaceLandmarksRequest(json: json)
    case .detectFaceCaptureQuality:
      return try DetectFaceCaptureQualityRequest(json: json)
    case .classifyImage:
      return try ClassifyImageRequest(json: json)
    case .generateImageFeaturePrint:
      return try GenerateImageFeaturePrintRequest(json: json)
    case .coreMlClassify:
      return try CoreMLClassifyRequest(json: json)
    case .coreMlRecognize:
      return try CoreMLRecognizeRequest(json: json)
    }
  }
}
