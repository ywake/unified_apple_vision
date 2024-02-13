import Vision

class RecognizeTextRequest: AnalyzeRequest {
  let minimumTextHeight: Float?
  let recognitionLevel: TextRecognitionLevel
  let automaticallyDetectsLanguage: Bool?
  let recognitionLanguages: [String]?
  let usesLanguageCorrection: Bool?
  let customWords: [String]?
  let maxCandidates: Int

  init(
    minimumTextHeight: Float?,
    recognitionLevel: TextRecognitionLevel,
    automaticallyDetectsLanguage: Bool?,
    recognitionLanguages: [String]?,
    usesLanguageCorrection: Bool?,
    customWords: [String]?,
    maxCandidates: Int?
  ) {
    self.minimumTextHeight = minimumTextHeight
    self.recognitionLevel = recognitionLevel
    self.automaticallyDetectsLanguage = automaticallyDetectsLanguage
    self.recognitionLanguages = recognitionLanguages
    self.usesLanguageCorrection = usesLanguageCorrection
    self.customWords = customWords
    self.maxCandidates = maxCandidates ?? 1
    super.init(type: .recognizeText)
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

  override func makeRequest(_ result: @escaping (AnalyzeResults?) -> Void) throws -> VNRequest {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(result)
    } else {
      throw PluginError.unsupportedPlatform
    }
  }

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ result: @escaping (AnalyzeResults?) -> Void) -> VNRecognizeTextRequest
  {
    let request = VNRecognizeTextRequest { req, err in
      if err != nil {
        Logger.error(err!.localizedDescription, "RecognizeTextRequest.makeRequest")
        result(nil)
        return
      }
      guard let observations = req.results as? [VNRecognizedTextObservation] else { return }
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
