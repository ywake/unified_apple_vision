import Vision

private typealias ModelInitializer = (Json) throws -> VNCoreMLModel

class CoreMLRecognizeRequest: ImageBasedRequest, AnalyzeRequest {
  let model: VNCoreMLModel
  let imageCropAndScaleOption: VNImageCropAndScaleOption?

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
    let modelPath = try json.str("model_path")
    let url = try URL(fileURLWithPath: modelPath)
    let mlModel = try MLModel(contentsOf: url)
    let model = try VNCoreMLModel(for: mlModel)
    self.init(
      parent: try ImageBasedRequest(json: json),
      model: model,
      imageCropAndScaleOption: json.strOr("image_crop_and_scale_option").map {
        VNImageCropAndScaleOption(byName: $0)
      }
    )
  }

  func type() -> RequestType {
    return .coreMlRecognize
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    Logger.d("Making request: \(self.type().rawValue)", "\(self.type().rawValue)>makeRequest")
    if #available(iOS 12.0, macOS 10.14, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "12.0", macOS: "10.14")
    }
  }

  @available(iOS 12.0, macOS 10.14, *)
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
    return result.map { ($0 as? VNRecognizedObjectObservation)?.toDict() ?? [:] }
  }
}
