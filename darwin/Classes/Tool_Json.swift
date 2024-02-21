#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class Json {
  let dictData: [String: Any]

  init(_ data: [String: Any]) {
    self.dictData = data
  }

  private func value<T>(_ key: String, _ require: Bool) throws -> T? {
    let value = dictData[key] as? T
    if require && value == nil {
      throw PluginError.missingRequiredKey(key)
    }
    return value
  }

  func bool(_ key: String) throws -> Bool { try value(key, true)! }
  func boolOr(_ key: String) -> Bool? { try? value(key, false) }

  func int(_ key: String) throws -> Int { try value(key, true)! }
  func intOr(_ key: String) -> Int? { try? value(key, false) }

  func str(_ key: String) throws -> String { try value(key, true)! }
  func strOr(_ key: String) -> String? { try? value(key, false) }

  func float(_ key: String) throws -> Float { try value(key, true)! }
  func floatOr(_ key: String) -> Float? { try? value(key, false) }

  func double(_ key: String) throws -> Double { try value(key, true)! }
  func doubleOr(_ key: String) -> Double? { try? value(key, false) }

  func array<T>(_ key: String) throws -> [T] { try value(key, true)! }
  func arrayOr<T>(_ key: String) -> [T]? { try? value(key, false) }

  private func _json(_ key: String, _ require: Bool) throws -> Json? {
    let dict: [String: Any]? = try value(key, require)
    if let dict = dict {
      return Json(dict)
    } else {
      return nil
    }
  }
  func json(_ key: String) throws -> Json { try _json(key, true)! }
  func jsonOr(_ key: String) -> Json? { try? _json(key, false) }

  private func _jsonArray(_ key: String, _ require: Bool) throws -> [Json]? {
    let array: [[String: Any]]? = try value(key, require)
    if let array = array {
      return array.map { Json($0) }
    } else {
      return nil
    }
  }
  func jsonArray(_ key: String) throws -> [Json] { try _jsonArray(key, true)! }
  func jsonArrayOr(_ key: String) -> [Json]? { try? _jsonArray(key, false) }

  func bytes(_ key: String) throws -> FlutterStandardTypedData { try value(key, true)! }
  func bytesOr(_ key: String) -> FlutterStandardTypedData? { try? value(key, false) }
}
