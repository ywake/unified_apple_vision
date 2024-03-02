import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

enum Method {
  case logging
  case analyze
  case coreML

  init?(_ name: String) {
    switch name {
    case Method.logging.name: self = .logging
    case Method.analyze.name: self = .analyze
    case Method.coreML.name: self = .coreML
    default: return nil
    }
  }

  var name: String {
    switch self {
    case .logging: return "logging"
    case .analyze: return "analyze"
    case .coreML: return "coreML"
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
