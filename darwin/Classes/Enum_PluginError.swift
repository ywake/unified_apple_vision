#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

enum PluginError: Error {
  /// InpuImage.init failed
  case invalidImageData
  /// handler.perform(requests) occurs error
  case analyzePerformError(msg: String)
  /// completionHandler returns nil
  case analyzeRequestError(msg: String)
  /// results is nil
  case resultsNotFound(AnalyzeRequest)
  /// Unsupported platform
  case unsupportedPlatform(iOS: String, macOS: String)
  /// Unexpected error
  case unexpectedError(msg: String = "Unexpected Errors")
  /// Missing required key when parsing json
  case missingRequiredKey(String)
  /// AnalyzeRequest.makeRequest returns nil
  case failedToCreateRequest(AnalyzeRequest)
  /// Invalid request
  case invalidRequest(msg: String)

  func code() -> String {
    switch self {
    case .invalidImageData:
      return "INVALID_IMAGE_DATA"
    case .analyzePerformError:
      return "ANALYZE_PERFORM_ERROR"
    case .analyzeRequestError:
      return "ANALYZE_REQUEST_ERROR"
    case .resultsNotFound:
      return "RESULTS_NOT_FOUND"
    case .unsupportedPlatform:
      return "UNSUPPORTED_PLATFORM"
    case .unexpectedError:
      return "UNEXPECTED_ERROR"
    case .missingRequiredKey:
      return "MISSING_REQUIRED_KEY"
    case .failedToCreateRequest:
      return "FAILED_TO_CREATE_REQUEST"
    case .invalidRequest:
      return "INVALID_REQUEST"
    }
  }

  func message() -> String {
    switch self {
    case .invalidImageData:
      return "Invalid Image Data"
    case .analyzePerformError(let msg):
      return msg
    case .analyzeRequestError(let msg):
      return msg
    case .resultsNotFound(let req):
      return "Results not found. type: \(req.type()), id: \(req.id())"
    case .unsupportedPlatform(let iOS, let macOS):
      return "This method is only supported on iOS \(iOS)+ and macOS \(macOS)+."
    case .unexpectedError(let msg):
      return msg
    case .missingRequiredKey(let key):
      return "Missing required key: \(key)"
    case .failedToCreateRequest(let req):
      return "Failed to create Request. Skiped. type: \(req.type()), id: \(req.id())"
    case .invalidRequest(let msg):
      return msg
    }
  }

  func toDict() -> [String: Any] {
    return [
      "code": self.code(),
      "message": self.message(),
    ]
  }

  func toFlutterError() -> FlutterError {
    return FlutterError(
      code: self.code(),
      message: self.message(),
      details: nil
    )
  }
}
