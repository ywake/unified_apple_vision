import Vision

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

public class UnifiedAppleVisionPlugin: NSObject, FlutterPlugin {
  private let channel: FlutterMethodChannel
  private let analyzeApi: AnalyzeApi

  public init(channel: FlutterMethodChannel) {
    self.channel = channel
    self.analyzeApi = AnalyzeApi(channel: channel)
    Logger.shared.channel = channel
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
    let funcName = "handle"
    Logger.d("method: \(call.method)", funcName)
    let arg = Json(call.arguments as! [String: Any])
    Task(priority: TaskPriority(byNameOr: arg.strOr("priority"))) {
      var res: Any? = nil
      do {
        switch PluginApi(byNameOr: call.method) {
        case .analyze:
          try self.analyzeApi.execute(arg)
          res = true
        case .logging:
          try Logger.setLogLevel(arg)
          res = true
        // case "supportedRecognitionLanguages":
        //   self.supportedRecognitionLanguages(arg, result)
        default:
          Logger.e("NotImplemented \(call.method)", funcName)
          res = FlutterMethodNotImplemented
        }
      } catch let err as PluginError {
        Logger.e(err.message(), funcName)
        res = err.toFlutterError()
      } catch {
        Logger.e(error.localizedDescription, funcName)
        let err = PluginError.unexpectedError(msg: error.localizedDescription)
        res = err.toFlutterError()
      }
      Task { @MainActor in
        result(res)
      }
    }
  }
}

enum PluginApi {
  case logging
  case analyze

  init?(byNameOr name: String) {
    switch name {
    case Logger.methodKey:
      self = .logging
    case AnalyzeApi.methodKey:
      self = .analyze
    default:
      return nil
    }
  }
}
