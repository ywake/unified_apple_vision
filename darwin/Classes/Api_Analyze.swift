import Foundation
import Vision

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class AnalyzeApi {
  static let key = "analyze"
  let channel: FlutterMethodChannel
  private let sequence = VNSequenceRequestHandler()

  init(channel: FlutterMethodChannel) {
    self.channel = channel
  }

  func execute(_ args: Json) {
    let qos = DispatchQoS.QoSClass(byNameOr: args.strOr("qos"))
    DispatchQueue.global(qos: qos).async {
      var output: Any?
      do {
        let input: AnalyzeInput = try AnalyzeInput(json: args)
        try self.analyze(input)
      } catch let err as PluginError {
        Logger.error(err.message(), "AnalyzeApi.execute")
        self.failure(nil, err)
      } catch {
        Logger.error(error.localizedDescription, "AnalyzeApi.execute")
        let err = PluginError.unexpectedError(msg: error.localizedDescription)
        self.failure(nil, err)
      }
    }
  }

  private func success(_ requestId: String, _ results: [[String: Any]]) {
    let data = [
      "results": results
    ]
    self.response(isSuccess: true, requestId: requestId, data: data)
  }

  private func failure(_ requestId: String? = nil, _ error: PluginError) {
    let data = [
      "error": error.toDict()
    ]
    self.response(isSuccess: false, requestId: requestId, data: data)
  }

  /// Send response to Flutter
  ///
  /// Even if it fails, it must always return a result for each request.
  private func response(
    isSuccess: Bool,
    requestId: String?,
    data: [String: Any]
  ) {
    let res =
      [
        "request_id": requestId,
        "is_success": isSuccess,
      ] + data
    var serialized: String
    do {
      let json = try JSONSerialization.data(withJSONObject: res, options: [])
      serialized = String(data: json, encoding: .utf8)!
    } catch {
      serialized = """
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
    DispatchQueue.main.async {
      self.channel.invokeMethod(AnalyzeApi.key, arguments: serialized)
    }
  }

  private func analyze(_ input: AnalyzeInput) throws {
    let funcName = "analyze"

    // build requests
    let requests = input.requests.compactMap { request -> VNRequest? in
      let vnRequest = request.makeRequest { vnReq, err in
        // *** Return the result to Flutter ***
        do {
          let results = try request.getResults(vnReq, err)
          self.success(request.id(), results)
        } catch {
          var err: PluginError
          if error is PluginError {
            err = error as! PluginError
          } else {
            err = PluginError.unexpectedError(msg: error.localizedDescription)
          }
          Logger.error(err.message(), "\(funcName)>onResult")
          self.failure(request.id(), err)
        }
      }
      if vnRequest == nil {
        let err = PluginError.failedToCreateRequest(request)
        Logger.error(err.message(), funcName)
        self.failure(request.id(), err)
      }
      return vnRequest
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
      throw PluginError.analyzePerformError(msg: error.localizedDescription)
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
        Logger.debug("Comming Request: \(json.dictData)", funcName)
        let requestType = RequestType(try json.str("request_type"))
        return try requestType?.jsonToRequest(json)
      }
    )
  }
}