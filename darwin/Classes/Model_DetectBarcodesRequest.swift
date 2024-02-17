import Vision

class DetectBarcodesRequest: AnalyzeRequest {
  let symbologies: [VNBarcodeSymbology]?
  let coalesceCompositeSymbologies: Bool?

  init(
    symbologies: [VNBarcodeSymbology]?,
    coalesceCompositeSymbologies: Bool?
  ) {
    self.symbologies = symbologies
    self.coalesceCompositeSymbologies = coalesceCompositeSymbologies
  }

  convenience init?(_ arg: [String: Any]?) {
    guard let arg = arg else { return nil }

    let symbologiesStr = arg["symbologies"] as? [String]
    let symbologies = symbologiesStr?.compactMap { VNBarcodeSymbology(rawValue: $0) }
    self.init(
      symbologies: symbologies,
      coalesceCompositeSymbologies: arg["coalesceCompositeSymbologies"] as? Bool
    )
  }

  func type() -> RequestType {
    return .detectBarcodes
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      Logger.error(
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
    // TODO: Implement
    let request = VNDetectBarcodesRequest(completionHandler: handler)
    return request
  }

  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults? {
    if #available(iOS 11.0, macOS 10.13, *) {
      // TODO: Implement
      return DetectBarcodesResults(
        observations as! [VNBarcodeObservation]
      )
    } else {
      Logger.error(
        "DetectBarcodesRequest requires iOS 11.0+ or macOS 10.13+",
        "\(self.type().rawValue)>makeResults"
      )
      return nil
    }
  }
}
