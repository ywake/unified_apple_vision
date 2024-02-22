import Vision

class RecognizeTextRequest: AnalyzeRequest {
  let requestId: String
  let minimumTextHeight: Float?
  let recognitionLevel: VNRequestTextRecognitionLevel
  let automaticallyDetectsLanguage: Bool?
  let recognitionLanguages: [String]?
  let usesLanguageCorrection: Bool?
  let customWords: [String]?
  let maxCandidates: Int

  init(
    requestId: String,
    minimumTextHeight: Float?,
    recognitionLevel: VNRequestTextRecognitionLevel,
    automaticallyDetectsLanguage: Bool?,
    recognitionLanguages: [String]?,
    usesLanguageCorrection: Bool?,
    customWords: [String]?,
    maxCandidates: Int?
  ) {
    self.requestId = requestId
    self.minimumTextHeight = minimumTextHeight
    self.recognitionLevel = recognitionLevel
    self.automaticallyDetectsLanguage = automaticallyDetectsLanguage
    self.recognitionLanguages = recognitionLanguages
    self.usesLanguageCorrection = usesLanguageCorrection
    self.customWords = customWords
    self.maxCandidates = maxCandidates ?? 1
  }

  convenience init(json: Json) throws {
    let level = try json.strOr("recognition_level") ?? ""
    self.init(
      requestId: try json.str("request_id"),
      minimumTextHeight: json.floatOr("minimum_text_height"),
      recognitionLevel: VNRequestTextRecognitionLevel(byName: level),
      automaticallyDetectsLanguage: json.boolOr("automatically_detects_language"),
      recognitionLanguages: json.arrayOr("recognition_languages"),
      usesLanguageCorrection: json.boolOr("uses_language_correction"),
      customWords: json.arrayOr("custom_words"),
      maxCandidates: json.intOr("max_candidates")
    )
  }

  func type() -> RequestType {
    return .recognizeText
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(handler)
    } else {
      Logger.e(
        "RecognizeTextRequest requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNRecognizeTextRequest
  {
    let request = VNRecognizeTextRequest(completionHandler: handler)
    if let minimumTextHeight = self.minimumTextHeight {
      request.minimumTextHeight = minimumTextHeight
    }
    request.recognitionLevel = self.recognitionLevel
    if #available(iOS 16.0, macOS 13.0, *) {
      if let automaticallyDetectsLanguage = self.automaticallyDetectsLanguage {
        request.automaticallyDetectsLanguage = automaticallyDetectsLanguage
      }
    } else if self.automaticallyDetectsLanguage != nil {
      Logger.w("automaticallyDetectsLanguage is available on iOS 16.0+ and macOS 13.0+")
    }
    if let recognitionLanguages = self.recognitionLanguages {
      request.recognitionLanguages = recognitionLanguages
    }
    if let usesLanguageCorrection = self.usesLanguageCorrection {
      request.usesLanguageCorrection = usesLanguageCorrection
    }
    if let customWords = self.customWords {
      request.customWords = customWords
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNRecognizedTextObservation)?.toDict(self.maxCandidates) ?? [:] }
  }
}

extension VNRequestTextRecognitionLevel {
  init(byName name: String) {
    switch name {
    case "fast":
      self = .fast
    default:
      self = .accurate
    }
  }
}
