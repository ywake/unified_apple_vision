#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

enum PluginError: Error {
  case invalidImageData
  case analyzeError(msg: String)
  case unsupportedPlatform
  case unexpectedError(msg: String = "Unexpected Errors")
  case missingRequiredKey(String)
  case invalidValue(String)

  func toFlutterError() -> FlutterError {
    switch self {
    case .invalidImageData:
      return FlutterError(
        code: "INVALID_IMAGE_DATA",
        message: "Invalid Image Data",
        details: nil
      )
    case .analyzeError(let msg):
      return FlutterError(
        code: "ANALYZE_ERROR",
        message: msg,
        details: nil
      )
    case .unsupportedPlatform:
      return FlutterError(
        code: "UNSUPPORTED_PLATFORM",
        message: "This method is only supported on iOS 13.0+ and macOS 10.15+.",
        details: nil
      )
    case .unexpectedError(let msg):
      return FlutterError(
        code: "UNEXPECTED_ERROR",
        message: msg,
        details: nil
      )
    case .missingRequiredKey(let key):
      return FlutterError(
        code: "MISSING_REQUIRED_KEY",
        message: key,
        details: nil
      )
    case .invalidValue(let key):
      return FlutterError(
        code: "INVALID_VALUE",
        message: key,
        details: nil
      )
    }
  }
}
