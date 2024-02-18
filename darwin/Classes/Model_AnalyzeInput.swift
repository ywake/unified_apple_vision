import CoreImage
import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class AnalyzeInput {
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

    let analyzeRequests = requests.compactMap { req -> AnalyzeRequest? in
      guard let req = req as? [String: Any] else { return nil }
      Logger.debug("Comming Request: \(req)", "AnalyzeInput")
      let requestTypeStr = req["request_type"] as? String ?? ""
      guard let requestType = RequestType(requestTypeStr) else { return nil }
      return requestType.mapToRequest(req)
    }

    self.init(
      image: image,
      mode: RequestMode(mode),
      requests: analyzeRequests
    )
  }
}
