import Flutter

enum PluginError: Error {
  case invalidImageData

  func toFlutterError() -> FlutterError {
    switch self {
    case .invalidImageData:
      return FlutterError(
        code: "Invalid Image Data",
        message: "Invalid Image Data",
        details: nil
      )
    }
  }
}
