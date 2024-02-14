import CoreImage
import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class PluginInput {
  let image: InputImage
  let mode: RequestMode
  let requests: [AnalyzeRequest]

  init(
    image: InputImage,
    mode: RequestMode,
    requests: [AnalyzeRequest]
  ) {
    self.image = image
    self.mode = mode
    self.requests = requests
  }

  convenience init(_ arg: [String: Any]) throws {
    let image = try InputImage(arg["image"] as? [String: Any])
    let mode = arg["mode"] as? String ?? "image"

    let requests = arg["requests"] as? [[String: Any]] ?? []

    let analysisRequests = requests.compactMap { req -> AnalyzeRequest? in
      guard let req = req as? [String: Any] else { return nil }
      let requestTypeStr = req["request_type"] as? String ?? ""
      guard let requestType = AnalysisType(requestTypeStr) else { return nil }
      return requestType.analysisRequest(req)
    }

    self.init(
      image: image,
      mode: RequestMode(mode),
      requests: analysisRequests
    )
  }
}
