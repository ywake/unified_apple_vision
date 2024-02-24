import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

enum Method {
  case logging
  case analyze

  init?(_ name: String) {
    switch name {
    case Method.logging.name: self = .logging
    case Method.analyze.name: self = .analyze
    default: return nil
    }
  }

  var name: String {
    switch self {
    case .logging:
      return "logging"
    case .analyze:
      return "analyze"
    }
  }

  func invoke(_ channel: FlutterMethodChannel, _ payload: String) {
    if Thread.isMainThread {
      self._invoke(channel, payload)
    } else {
      Task { @MainActor in
        self._invoke(channel, payload)
      }
    }
  }

  private func _invoke(_ channel: FlutterMethodChannel, _ payload: String) {
    channel.invokeMethod(self.name, arguments: payload)
  }
}
