import Vision

class CoreMLClassifyRequest: CoreMLRequest {
  override func type() -> RequestType {
    return .coreMlClassify
  }

  override func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNClassificationObservation)?.toDict() ?? [:] }
  }
}
