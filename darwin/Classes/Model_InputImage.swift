import CoreImage
import Flutter

class InputImage {
  var ciImage: CIImage
  var orientation: CGImagePropertyOrientation

  init(ciImage: CIImage, orientation: CGImagePropertyOrientation) {
    self.ciImage = ciImage
    self.orientation = orientation
  }

  convenience init(_ arg: [String: Any]?) throws {
    let funcName = "InputImage.init"
    guard let arg = arg else {
      Logger.error("arg[\"image\"] is nil", funcName)
      throw PluginError.invalidImageData
    }

    let bytes = arg["data"] as? FlutterStandardTypedData
    let width = arg["width"] as? Int ?? 0
    let height = arg["height"] as? Int ?? 0
    let orientation = arg["orientation"] as? String ?? "down"

    guard let bytes = bytes else {
      Logger.error("bytes is nil", funcName)
      throw PluginError.invalidImageData
    }
    let data = Data(bytes.data)
    if data.count != height * width * 4 {
      Logger.error("invalid data size", funcName)
      throw PluginError.invalidImageData
    }
    let size = CGSize(width: width, height: height)
    let ciImage = CIImage(
      bitmapData: data,
      bytesPerRow: width * 4,
      size: size,
      format: CIFormat.RGBA8,
      colorSpace: nil
    )
    self.init(
      ciImage: ciImage,
      orientation: Orientation(orientation).toCGImagePropertyOrientation()
    )
  }
}
