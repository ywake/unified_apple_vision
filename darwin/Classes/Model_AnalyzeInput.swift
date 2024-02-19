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

  convenience init(json: Json) throws {
    let mode = try json.strOr("mode") ?? "image"
    self.init(
      image: try InputImage(json: json.json("image")),
      mode: RequestMode(mode),
      requests: try json.jsonArray("requests").compactMap { json -> AnalyzeRequest? in
        Logger.debug("Comming Request: \(json)", "AnalyzeInput")
        let requestType = RequestType(try json.str("request_type"))
        return try requestType?.jsonToRequest(json)
      }
    )
  }
}
