import Vision

class RecognizeTextHandler {
  let minimumTextHeight: Float?
  let recognitionLevel: String?
  let automaticallyDetectsLanguage: Bool?
  let recognitionLanguages: [String]?
  let usesLanguageCorrection: Bool?
  let customWords: [String]?
  let maxCandidates: Int

  init(
    minimumTextHeight: Float? = nil,
    recognitionLevel: String? = nil,
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

  convenience init(_ arg: [String: Any]) {
    self.init(
      minimumTextHeight: arg["minimum_text_height"] as? Float,
      recognitionLevel: arg["recognition_level"] as? String,
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
  func buildRequest(_ results: AnalyzeResults) -> VNRecognizeTextRequest {
    let request = VNRecognizeTextRequest { request, error in
      if error != nil {
        print(error!.localizedDescription)
        return
      }
      return
    }
    if let minimumTextHeight = self.minimumTextHeight {
      request.minimumTextHeight = minimumTextHeight
    }
    if let recognitionLevel = self.recognitionLevel {
      switch recognitionLevel {
      case "fast":
        request.recognitionLevel = VNRequestTextRecognitionLevel.fast
      default:
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
      }
    }
    if #available(iOS 16.0, macOS 13.0, *) {
      if let automaticallyDetectsLanguage = self.automaticallyDetectsLanguage {
        request.automaticallyDetectsLanguage = automaticallyDetectsLanguage
      }
    } else if self.automaticallyDetectsLanguage != nil {
      print("Warning: automaticallyDetectsLanguage is available on iOS 16.0+ and macOS 13.0+")
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
