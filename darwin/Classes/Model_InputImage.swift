import CoreImage

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class InputImage {
  var ciImage: CIImage
  var orientation: CGImagePropertyOrientation

  init(ciImage: CIImage, orientation: CGImagePropertyOrientation) {
    self.ciImage = ciImage
    self.orientation = orientation
  }

  convenience init(json: Json) throws {
    let funcName = "InputImage.init"
    let bytes = try json.bytes("data")
    let width = try json.int("width")
    let height = try json.int("height")
    let orientation = json.strOr("orientation") ?? "down"

    let data = Data(bytes.data)
    let size = CGSize(width: width, height: height)
    if data.count != height * width * 4 {
      Logger.e("invalid data size", funcName)
      throw PluginError.invalidImageData
    }
    let ciImage = CIImage(
      bitmapData: data,
      bytesPerRow: width * 4,
      size: size,
      format: CIFormat.RGBA8,
      colorSpace: nil
    )
    self.init(
      ciImage: ciImage,
      orientation: CGImagePropertyOrientation(byName: orientation)
    )
  }
}

extension CGImagePropertyOrientation {
  init(byName name: String) {
    switch name {
    case "up": self = .up
    case "upMirrored": self = .upMirrored
    case "down": self = .down
    case "downMirrored": self = .downMirrored
    case "left": self = .left
    case "leftMirrored": self = .leftMirrored
    case "right": self = .right
    case "rightMirrored": self = .rightMirrored
    default: self = .down
    }
  }
}
