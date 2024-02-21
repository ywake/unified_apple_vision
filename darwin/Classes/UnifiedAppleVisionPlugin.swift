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
    let arg = Json(call.arguments as! [String: Any])
    Logger.debug("method: \(call.method)", "handle")
    let api: PluginApi = PluginApi(byName: call.method)
    switch api {
    case .analyze:
      self.analyzeApi.execute(arg)
    // case "supportedRecognitionLanguages":
    //   self.supportedRecognitionLanguages(arg, result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

enum PluginApi {
  case setLogLevel
  case analyze

  init(byName name: String) {
    switch name {
    case "setLogLevel":
      self = .setLogLevel
    case AnalyzeApi.key:
      self = .analyze
    default:
      self = .setLogLevel
    }
  }
}
