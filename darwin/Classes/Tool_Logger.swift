import Dispatch
import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class Logger {
  static let methodKey = "logging"

  // for singleton
  static let shared = Logger()
  private init() {}

  enum Level: Int {
    case debug
    case info
    case warning
    case error
    case none

    init(byName name: String) {
      switch name {
      case "debug": self = .debug
      case "info": self = .info
      case "warning": self = .warning
      case "error": self = .error
      default: self = .none
      }
    }

    var name: String {
      switch self {
      case .debug: return "debug"
      case .info: return "info"
      case .warning: return "warning"
      case .error: return "error"
      case .none: return "none"
      }
    }
  }

  var level: Level = .none
  private static let pluginName: String = "UnifiedAppleVisionPlugin"
  var channel: FlutterMethodChannel?

  static func setLogLevel(_ arg: Json) throws {
    let level = Level(byName: try arg.str("level"))
    self.shared.level = level
  }

  static func _log(_ level: Level, _ message: String, _ symbol: String?) {
    if Logger.shared.level.rawValue > level.rawValue {
      return
    }
    var prefix = Logger.pluginName
    if let s = symbol {
      prefix += ">\(s)"
    }
    print("[\(prefix)] \(message)")
    // send to Flutter
    guard let channel = Logger.shared.channel else { return }
    let payload = self.serialize([
      "level": level.name,
      "message": message,
      "symbol": symbol,
    ])
    if Thread.isMainThread {
      channel.invokeMethod(Logger.methodKey, arguments: payload)
    } else {
      DispatchQueue.main.async {
        channel.invokeMethod(Logger.methodKey, arguments: payload)
      }
    }
  }

  private static func serialize(_ data: [String: Any?]) -> String {
    do {
      let json = try JSONSerialization.data(withJSONObject: data, options: [])
      return String(data: json, encoding: .utf8)!
    } catch {
      return """
          {
            "level": "error",
            "message": "\(error.localizedDescription)"
          }
        """
    }
  }

  static func d(_ message: String, _ symbol: String? = nil) {
    _log(.debug, message, symbol)
  }

  static func i(_ message: String, _ symbol: String? = nil) {
    _log(.info, message, symbol)
  }

  static func w(_ message: String, _ symbol: String? = nil) {
    _log(.warning, message, symbol)
  }

  static func e(_ message: String, _ symbol: String? = nil) {
    _log(.error, message, symbol)
  }
}
