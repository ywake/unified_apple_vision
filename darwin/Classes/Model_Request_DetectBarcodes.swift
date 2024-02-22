import Vision

class DetectBarcodesRequest: AnalyzeRequest {
  let requestId: String
  let symbologies: [VNBarcodeSymbology]?
  let coalesceCompositeSymbologies: Bool?

  init(
    requestId: String,
    symbologies: [VNBarcodeSymbology]?,
    coalesceCompositeSymbologies: Bool?
  ) {
    self.requestId = requestId
    self.symbologies = symbologies
    self.coalesceCompositeSymbologies = coalesceCompositeSymbologies
  }

  convenience init(json: Json) throws {
    self.init(
      requestId: try json.str("request_id"),
      symbologies: json.arrayOr("symbologies")?.compactMap { VNBarcodeSymbology(rawValue: $0) },
      coalesceCompositeSymbologies: json.boolOr("coalesceCompositeSymbologies")
    )
  }

  func type() -> RequestType {
    return .detectBarcodes
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.e(
        "DetectBarcodesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNDetectBarcodesRequest
  {
    let request = VNDetectBarcodesRequest(completionHandler: handler)
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNBarcodeObservation)?.toDict() ?? [:] }
  }
}
