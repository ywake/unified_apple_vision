import Vision

typealias ModelInitializer = (Json) throws -> VNCoreMLModel

class CoreMLClassificationRequest: ImageBasedRequest, AnalyzeRequest {
  let model: VNCoreMLModel
  let imageCropAndScaleOption: VNImageCropAndScaleOption?

  private static var registry: [String: ModelInitializer] = [:]
  static func registerModelInitializer(
    _ name: String,
    _ initializer: @escaping ModelInitializer
  ) {
    registry[name] = initializer
  }

  init(
    parent: ImageBasedRequest,
    model: VNCoreMLModel,
    imageCropAndScaleOption: VNImageCropAndScaleOption?
  ) {
    self.model = model
    self.imageCropAndScaleOption = imageCropAndScaleOption
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    let modelInitializer = try CoreMLClassificationRequest.registry[json.str("model_name")]
    guard let model = try modelInitializer?(json) else {
      throw PluginError.invalidRequest(msg: "Model not found. Check 'model_name'.")
    }
    self.init(
      parent: try ImageBasedRequest(json: json),
      model: model,
      imageCropAndScaleOption: json.strOr("image_crop_and_scale_option").map {
        VNImageCropAndScaleOption(byName: $0)
      }
    )
  }

  func type() -> RequestType {
    return .coreMlClassification
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    if #available(iOS 11.0, macOS 10.13, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "11.0", macOS: "10.13")
    }
  }

  @available(iOS 11.0, macOS 10.13, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNCoreMLRequest
  {
    let request = VNCoreMLRequest(model: self.model, completionHandler: handler)
    if let imageCropAndScaleOption = self.imageCropAndScaleOption {
      request.imageCropAndScaleOption = imageCropAndScaleOption
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNClassificationObservation)?.toDict() ?? [:] }
  }
}
