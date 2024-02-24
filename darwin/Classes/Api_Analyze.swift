import Foundation
import Vision

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class AnalyzeApi {
  let method = Method.analyze
  let channel: FlutterMethodChannel
  private let sequence = VNSequenceRequestHandler()

  init(channel: FlutterMethodChannel) {
    self.channel = channel
  }

  func execute(_ args: Json) throws {
    let input: AnalyzeInput = try AnalyzeInput(json: args)
    try self.analyze(input)
  }

  private func success(_ requestId: String, _ results: [[String: Any]]) {
    self.response(
      isSuccess: true,
      requestId: requestId,
      data: [
        "results": results
      ]
    )
  }

  private func failure(_ requestId: String, _ error: PluginError) {
    self.response(
      isSuccess: false,
      requestId: requestId,
      data: [
        "error": error.toDict()
      ]
    )
  }

  /// Send response to Flutter
  ///
  /// Even if it fails, it must always return a result for each request.
  private func response(
    isSuccess: Bool,
    requestId: String,
    data: [String: Any]
  ) {
    let payload = self.serialize(
      isSuccess: isSuccess,
      requestId: requestId,
      data: [
        "request_id": requestId,
        "is_success": isSuccess,
      ] + data
    )
    method.invoke(channel, payload)
  }

  private func serialize(
    isSuccess: Bool,
    requestId: String?,
    data: [String: Any]
  ) -> String {
    do {
      let json = try JSONSerialization.data(withJSONObject: data, options: [])
      return String(data: json, encoding: .utf8)!
    } catch {
      return """
        {
          "request_id": "\(requestId)",
          "is_success": \(isSuccess),
          "error": {
            "code": "JSON_SERIALIZATION_ERROR",
            "message": "\(error.localizedDescription)"
          }
        }
        """
    }
  }

  private func analyze(_ input: AnalyzeInput) throws {
    let funcName = "analyze"

    // build requests
    let requests = input.requests.compactMap { request -> VNRequest? in
      let completion: VNRequestCompletionHandler = { vnReq, err in
        do {
          let results = try request.getResults(vnReq, err)
          self.success(request.id(), results)
        } catch {
          self.errorHandler(request.id(), error)
        }
      }
      do {
        let vnRequest = try request.makeRequest(completion)
        return vnRequest
      } catch {
        self.errorHandler(request.id(), error)
        return nil
      }
    }
    Logger.d("build requests: \(requests.count)", funcName)

    // perform requests
    Logger.d("perform requests: \(input.mode)", funcName)
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
      Logger.d("perform: \(error)", funcName)
      throw PluginError.analyzePerformError(msg: error.localizedDescription)
    }
  }

  private func errorHandler(_ requestId: String, _ error: Error) {
    let funcName = "analyze"
    if let err = error as? PluginError {
      Logger.e(err.message(), funcName)
      self.failure(requestId, err)
    } else {
      let err = PluginError.unexpectedError(msg: error.localizedDescription)
      Logger.e(err.message(), funcName)
      self.failure(requestId, err)
    }
  }
}

private class AnalyzeInput {
  enum RequestMode: String {
    case image = "image"
    case sequence = "sequence"

    init(_ name: String?) {
      switch name {
      case "sequence": self = .sequence
      default: self = .image
      }
    }
  }

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
    let funcName = "AnalyzeInput.init(json: Json)"
    self.init(
      image: try InputImage(json: json.json("image")),
      mode: RequestMode(json.strOr("mode")),
      requests: try json.jsonArray("requests").compactMap { json -> AnalyzeRequest? in
        Logger.d("Comming Request: \(json.dictData)", funcName)
        let requestType = RequestType(try json.str("request_type"))
        return try requestType?.jsonToRequest(json)
      }
    )
  }
}
