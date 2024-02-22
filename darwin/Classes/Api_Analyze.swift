import Foundation
import Vision

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class AnalyzeApi {
  static let methodKey = "analyze"
  let channel: FlutterMethodChannel
  private let sequence = VNSequenceRequestHandler()

  init(channel: FlutterMethodChannel) {
    self.channel = channel
  }

  func execute(_ args: Json) throws {
    self._execute(args) { err in
      Logger.e(err.message(), funcName)
      throw err
    }
  }

  private func _execute(_ args: Json, _ onError: @escaping (PluginError) -> Void) {
    let qos = DispatchQoS.QoSClass(byNameOr: args.strOr("qos"))
    DispatchQueue.global(qos: qos).async {
      do {
        let input: AnalyzeInput = try AnalyzeInput(json: args)
        try self.analyze(input)
      } catch let err as PluginError {
        onError(err)
      } catch {
        let err = PluginError.unexpectedError(msg: error.localizedDescription)
        onError(err)
      }
    }
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
    var payload = self.serialize(
      isSuccess: isSuccess,
      requestId: requestId,
      data: [
        "request_id": requestId,
        "is_success": isSuccess,
      ] + data
    )
    DispatchQueue.main.async {
      self.channel.invokeMethod(AnalyzeApi.methodKey, arguments: payload)
    }
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
          Logger.e(err.message(), "\(funcName)>onResult")
          self.failure(request.id(), err)
        }
      }
      if vnRequest == nil {
        let err = PluginError.failedToCreateRequest(request)
        Logger.e(err.message(), funcName)
        self.failure(request.id(), err)
      }
      return vnRequest
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
