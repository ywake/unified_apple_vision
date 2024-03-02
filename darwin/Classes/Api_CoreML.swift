import Vision

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class CoreMLApi: OneToOneApi {
  init(channel: FlutterMethodChannel) {
    super.init(channel: channel, method: .coreML)
  }

  func compile(_ json: Json) throws {
    let requestId = try json.str("request_id")
    let modelPath = try json.str("model_path")
    let modelUrl = URL(fileURLWithPath: modelPath)
    if #available(iOS 16.0, macOS 13.0, *) {
      try MLModel.compileModel(at: modelUrl) { (res: Result<URL, Error>) in
        switch res {
        case .success(let url):
          self.success(requestId, ["compiled_model_path": url.path])
        case .failure(let error):
          let err = PluginError.unexpectedError(msg: error.localizedDescription)
          self.failure(requestId, err)
        }
      }
    } else {
      throw PluginError.unsupportedPlatform(iOS: "16.0", macOS: "13.0")
    }
  }
}
