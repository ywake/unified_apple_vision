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
    if #available(iOS 13.0, macOS 10.13, *) {
      do {
        let input = try PluginInput(call.arguments as! [String: Any])
        switch call.method {
        case "analyze":
          DispatchQueue.global(qos: input.qos).async {
            let res = self.analyze(input)
            let map = self.encode(res)
            DispatchQueue.main.async {
              result(map)
            }
          }
        default:
          result(FlutterMethodNotImplemented)
        }
      } catch PluginError.invalidImageData {
        result(PluginError.invalidImageData.toFlutterError())
      } catch {
        result(
          FlutterError(
            code: "Unexpected Errors",
            message: error.localizedDescription,
            details: nil
          )
        )
      }
    } else {
      result(
        FlutterError(
          code: "Unsupported Platform",
          message: "This plugin requires at least iOS 11.0 or macOS 10.13",
          details: nil
        )
      )
    }
  }

  private let sequence = VNSequenceRequestHandler()
  #if os(iOS)
    @available(iOS 13.0, macOS 10.13, *)
  #endif
  func analyze(_ input: PluginInput) -> AnalyzeResult {
    do {
      var results = AnalyzeResults()
      var requests: [VNRequest] = []
      if let recognizeTextHandler = input.recognizeTextHandler {
        let req = recognizeTextHandler.buildRequest(results)
        requests.append(req)
      }

      // perform requests
      switch input.handler {
      case .image:
        let handler = VNImageRequestHandler(
          ciImage: input.image,
          orientation: input.orientation
        )
        try handler.perform(requests)
      case .sequence:
        try self.sequence.perform(
          requests,
          on: input.image,
          orientation: input.orientation
        )
      }
    } catch {
      return error.localizedDescription
    }
    return "analyze"
  }

  func encode(_ results: AnalyzeResults) -> [String: Any?] {
    return [
      "recognize_text_result": results.recognizeTextResult
    ]
  }
}
