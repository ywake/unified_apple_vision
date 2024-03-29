import Vision

class GenerateImageFeaturePrintRequest: ImageBasedRequest, AnalyzeRequest {
  let imageCropAndScaleOption: VNImageCropAndScaleOption?

  init(
    parent: ImageBasedRequest,
    imageCropAndScaleOption: VNImageCropAndScaleOption?
  ) {
    self.imageCropAndScaleOption = imageCropAndScaleOption
    super.init(copy: parent)
  }

  convenience init(json: Json) throws {
    self.init(
      parent: try ImageBasedRequest(json: json),
      imageCropAndScaleOption: json.strOr("image_crop_and_scale_option").map {
        VNImageCropAndScaleOption(byName: $0)
      }
    )
  }

  func type() -> RequestType {
    return .generateImageFeaturePrint
  }

  func id() -> String {
    return self.requestId
  }

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {
    if #available(iOS 13.0, macOS 10.15, *) {
      return _makeRequest(handler)
    } else {
      throw PluginError.unsupportedPlatform(iOS: "13.0", macOS: "10.15")
    }
  }

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VNGenerateImageFeaturePrintRequest
  {
    let request = VNGenerateImageFeaturePrintRequest(completionHandler: handler)
    if let imageCropAndScaleOption = self.imageCropAndScaleOption {
      request.imageCropAndScaleOption = imageCropAndScaleOption
    }
    return request
  }

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map { ($0 as? VNFeaturePrintObservation)?.toDict() ?? [:] }
  }
}

extension VNImageCropAndScaleOption {
  init(byName name: String) {
    switch name {
    case "centerCrop":
      self = .centerCrop
    case "scaleFit":
      self = .scaleFit
    case "scaleFitRotate90CCW":
      self = .scaleFitRotate90CCW
    case "scaleFillRotate90CCW":
      self = .scaleFillRotate90CCW
    default:
      self = .scaleFill
    }
  }
}
