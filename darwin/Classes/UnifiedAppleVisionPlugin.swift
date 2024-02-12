import Flutter
import Vision

public class UnifiedAppleVisionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "unified_apple_vision",
      binaryMessenger: registrar.messenger()
    )
    let instance = UnifiedAppleVisionPlugin()
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

    if #available(iOS 13.0, macOS 10.13, *) {
      Logger.debug("platform available", funcName)
      let qosString = arg["qos"] as? String ?? "unspecified"
      let qos = QoS(qosString).toDispatchQoS()
      Logger.debug("qos: \(qos)", funcName)
      DispatchQueue.global(qos: qos).async {
        var output: Any?
        do {
          let input = try PluginInput(arg)
          Logger.debug("input: \(input)", funcName)
          let res = try self.analyze(input)
          Logger.debug("res: \(res)", funcName)
          let map = self.encode(res)
          Logger.debug("map: \(map)", funcName)
          Logger.debug("analyze: success", funcName)
          output = map
        } catch let error as PluginError {
          Logger.debug("analyze: \(error)", funcName)
          output = error.toFlutterError()
        } catch {
          Logger.debug("analyze: \(error)", funcName)
          let err = PluginError.unexpectedError(msg: error.localizedDescription)
          output = err.toFlutterError()
        }
        DispatchQueue.main.async {
          result(output)
        }
      }
    } else {
      Logger.debug("platform unavailable", funcName)
      result(PluginError.unsupportedPlatform.toFlutterError())
    }
  }

  private let sequence = VNSequenceRequestHandler()
  #if os(iOS)
    @available(iOS 13.0, macOS 10.13, *)
  #endif
  func analyze(_ input: PluginInput) throws -> AnalyzeResults {
    let funcName = "analyze"

    // build requests
    var results: AnalyzeResults = AnalyzeResults()
    var requests: [VNRequest] = []
    if let recognizeTextHandler = input.recognizeTextHandler {
      Logger.debug("build recognizeTextHandler request", funcName)
      let req = recognizeTextHandler.buildRequest { res in
        if let res = res {
          results.recognizeTextResults = res
        }
      }
      requests.append(req)
    }
    Logger.debug("build requests: \(requests.count)", funcName)

    // perform requests
    Logger.debug("perform requests: \(input.handler)", funcName)
    do {
      switch input.handler {
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
      return results
    } catch {
      Logger.debug("perform: \(error)", funcName)
      throw PluginError.analyzeError(msg: error.localizedDescription)
    }
  }

  func encode(_ results: AnalyzeResults) -> [String: Any?] {
    let funcName = "encode"
    Logger.debug("\(results)", funcName)

    return results.toData()
  }

  func supportedRecognitionLanguages(_ arg: [String: Any], _ result: @escaping FlutterResult) {
    let funcName = "supportedRecognitionLanguages"

    if #available(iOS 15.0, macOS 12.0, *) {
      Logger.debug("platform available", funcName)
      let levelStr = arg["recognition_level"] as? String ?? "accurate"
      let level = TextRecognitionLevel(levelStr)
      let request = VNRecognizeTextRequest()
      request.recognitionLevel = level.toVNRequestRecognitionLevel()
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
