#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class OneToOneApi {
  let method: Method
  let channel: FlutterMethodChannel

  init(
    channel: FlutterMethodChannel,
    method: Method
  ) {
    self.method = method
    self.channel = channel
  }

  func success(_ requestId: String, _ results: [String: Any]) {
    Logger.d("success", "OneToOneApi")
    Logger.d("requestId: \(requestId)", "OneToOneApi")
    Logger.d("results: \(results)", "OneToOneApi")
    self.response(
      isSuccess: true,
      requestId: requestId,
      data: [
        "results": results
      ]
    )
  }

  func failure(_ requestId: String, _ error: PluginError) {
    Logger.d("failure", "OneToOneApi")
    Logger.d("requestId: \(requestId)", "OneToOneApi")
    Logger.d("error: \(error)", "OneToOneApi")
    self.response(
      isSuccess: false,
      requestId: requestId,
      data: [
        "error": error.toDict()
      ]
    )
  }

  func response(
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
}
