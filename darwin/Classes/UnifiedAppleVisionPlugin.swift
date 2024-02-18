import Vision

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

public class UnifiedAppleVisionPlugin: NSObject, FlutterPlugin {
  private let channel: FlutterMethodChannel

  public init(channel: FlutterMethodChannel) {
    self.channel = channel
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    #if os(iOS)
      let messenger = registrar.messenger()
    #elseif os(macOS)
      let messenger = registrar.messenger
    #endif
    let channel = FlutterMethodChannel(
      name: "unified_apple_vision/method",
      binaryMessenger: messenger
    )
    let instance = UnifiedAppleVisionPlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arg = call.arguments as! [String: Any]
    let logLevelString = arg["log_level"] as? String ?? "none"
    Logger.shared.level = Logger.Level(name: logLevelString)

    Logger.debug("method: \(call.method)", "handle")
    switch call.method {
    case "analyze":
      self.callAnalyze(arg, result)
    case "supportedRecognitionLanguages":
      self.supportedRecognitionLanguages(arg, result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func callAnalyze(_ arg: [String: Any], _ result: @escaping FlutterResult) {
    let funcName = "callAnalyze"

    Logger.debug("platform available", funcName)
    let qosString = arg["qos"] as? String ?? "unspecified"
    let qos = QoS(qosString).toDispatchQoS()
    Logger.debug("qos: \(qos)", funcName)
    DispatchQueue.global(qos: qos).async {
      var output: Any?
      do {
        let input = try AnalyzeInput(arg)
        try self.analyze(input) { results in
          let json = try! JSONSerialization.data(withJSONObject: results, options: [])
          let data = String(data: json, encoding: .utf8)!
          Logger.debug("Send Results: \(data)", "\(funcName)>analyze.onResult")
          DispatchQueue.main.async {
            self.channel.invokeMethod("response", arguments: data)
          }
        }
      } catch let error as PluginError {
        Logger.debug("analyze: \(error)", funcName)
        output = error.toFlutterError()
      } catch {
        Logger.debug("analyze: \(error)", funcName)
        let err = PluginError.unexpectedError(msg: error.localizedDescription)
        output = err.toFlutterError()
      }
    }
  }

  private let sequence = VNSequenceRequestHandler()
  func analyze(
    _ input: AnalyzeInput, _ onResult: @escaping OnResultHandler
  ) throws {
    let funcName = "analyze"

    // build requests
    var requests: [VNRequest] = []
    for request: AnalyzeRequest in input.requests {
      let handler = request.getCompletionHandler(onResult)
      if let req = request.makeRequest(handler) {
        requests.append(req)
      } else {
        Logger.error("Failed to create \(request.type) Request. Skip.", funcName)
      }
    }
    Logger.debug("build requests: \(requests.count)", funcName)

    // perform requests
    Logger.debug("perform requests: \(input.mode)", funcName)
    do {
      switch input.mode {
      case .image:
        let handler = VNImageRequestHandler(
          ciImage: input.image.ciImage,
          orientation: input.image.orientation
        )
        try handler.perform(requests)
      case .sequence:
        try self.sequence.perform(
          requests,
          on: input.image.ciImage,
          orientation: input.image.orientation
        )
      }
    } catch {
      Logger.debug("perform: \(error)", funcName)
      throw PluginError.analyzeError(msg: error.localizedDescription)
    }
  }

  func supportedRecognitionLanguages(_ arg: [String: Any], _ result: @escaping FlutterResult) {
    let funcName = "supportedRecognitionLanguages"

    if #available(iOS 15.0, macOS 12.0, *) {
      Logger.debug("platform available", funcName)
      let request = VNRecognizeTextRequest()
      let levelStr = arg["recognition_level"] as? String ?? "accurate"
      request.recognitionLevel = VNRequestTextRecognitionLevel(levelStr)
      do {
        let langs = try request.supportedRecognitionLanguages()
        Logger.debug("langs: \(langs)", funcName)
        result(["supported_recognition_languages": langs])
      } catch {
        result(PluginError.unexpectedError(msg: error.localizedDescription).toFlutterError())
      }
    } else {
      Logger.debug("platform unavailable", funcName)
      result(PluginError.unsupportedPlatform.toFlutterError())
    }
  }
}
