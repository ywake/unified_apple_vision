import Vision

class RecognizeTextHandler {
  let minimumTextHeight: Float?
  let recognitionLevel: TextRecognitionLevel
  let automaticallyDetectsLanguage: Bool?
  let recognitionLanguages: [String]?
  let usesLanguageCorrection: Bool?
  let customWords: [String]?
  let maxCandidates: Int

  init(
    minimumTextHeight: Float? = nil,
    recognitionLevel: TextRecognitionLevel,
    automaticallyDetectsLanguage: Bool? = nil,
    recognitionLanguages: [String]? = nil,
    usesLanguageCorrection: Bool? = nil,
    customWords: [String]? = nil,
    maxCandidates: Int? = nil
  ) {
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

    let level = arg["recognition_level"] as? String ?? "accurate"
    self.init(
      minimumTextHeight: arg["minimum_text_height"] as? Float,
      recognitionLevel: TextRecognitionLevel(level),
      automaticallyDetectsLanguage: arg["automatically_detects_language"] as? Bool,
      recognitionLanguages: arg["recognition_languages"] as? [String],
      usesLanguageCorrection: arg["uses_language_correction"] as? Bool,
      customWords: arg["custom_words"] as? [String],
      maxCandidates: arg["max_candidates"] as? Int
    )
  }

  #if os(iOS)
    @available(iOS 13.0, macOS 10.13, *)
  #endif
  func buildRequest(_ result: @escaping (RecognizeTextResults?) -> Void)
    -> VNRecognizeTextRequest
  {
    let request = VNRecognizeTextRequest { request, error in
      if error != nil {
        Logger.error(error!.localizedDescription, "RecognizeTextHandler.buildRequest")
        result(nil)
        return
      }
      guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
      let res = RecognizeTextResults(
        observations,
        maxCandidates: self.maxCandidates
      )
      result(res)
    }
    if let minimumTextHeight = self.minimumTextHeight {
      request.minimumTextHeight = minimumTextHeight
    }
    request.recognitionLevel = self.recognitionLevel.toVNRequestRecognitionLevel()
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
}
