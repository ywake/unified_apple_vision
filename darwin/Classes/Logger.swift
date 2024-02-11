class Logger {
  // for singleton
  static let shared = Logger()
  private init() {}

  enum Level: Int {
    case debug
    case info
    case warning
    case error
    case none

    init(name: String) {
      switch name {
      case "debug": self = .debug
      case "info": self = .info
      case "warning": self = .warning
      case "error": self = .error
      default: self = .none
      }
    }
  }

  var level: Level = .none

  private static let pluginName: String = "UnifiedAppleVisionPlugin"

  static func _log(_ level: Level, _ message: String, _ symbol: String?) {
    if shared.level.rawValue < level.rawValue {
      return
    }
    var prefix = Logger.pluginName
    if let s = symbol {
      prefix += ">\(s)"
    }
    print("[\(prefix)] \(message)")
  }

  static func debug(_ message: String, _ symbol: String? = nil) {
    _log(.debug, message, symbol)
  }

  static func info(_ message: String, _ symbol: String? = nil) {
    _log(.info, message, symbol)
  }

  static func warning(_ message: String, _ symbol: String? = nil) {
    _log(.warning, message, symbol)
  }

  static func error(_ message: String, _ symbol: String? = nil) {
    _log(.error, message, symbol)
  }
}
