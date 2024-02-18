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

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }
    guard let requestId = arg["request_id"] as? String else { return nil }

    let level = arg["recognition_level"] as? String ?? "accurate"
    self.init(
      requestId: requestId,
      minimumTextHeight: arg["minimum_text_height"] as? Float,
      recognitionLevel: VNRequestTextRecognitionLevel(level),
      automaticallyDetectsLanguage: arg["automatically_detects_language"] as? Bool,
      recognitionLanguages: arg["recognition_languages"] as? [String],
      usesLanguageCorrection: arg["uses_language_correction"] as? Bool,
      customWords: arg["custom_words"] as? [String],
      maxCandidates: arg["max_candidates"] as? Int
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
      Logger.error(
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
      Logger.warning("automaticallyDetectsLanguage is available on iOS 16.0+ and macOS 13.0+")
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
    Logger.debug("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNRecognizedTextObservation)?.toDict(self.maxCandidates) ?? [:] }
  }
}