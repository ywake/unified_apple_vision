import Vision

@available(iOS 11.0, macOS 10.13, *)
class DetectBarcodesResults: AnalyzeResults {
  let observations: [VNBarcodeObservation]

  init(_ observations: [VNBarcodeObservation]) {
    self.observations = observations
  }

  func type() -> RequestType {
    return .detectBarcodes
  }

  func toDict() -> [[String: Any]] {
    return self.observations.map { observation in
      return observation.toDict()
    }
  }
}
