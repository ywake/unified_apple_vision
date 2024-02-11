import CoreImage
import Flutter
import Foundation

class PluginInput {
  let orientation: CGImagePropertyOrientation
  let handler: RequestHandler
  let image: CIImage
  let recognizeTextHandler: RecognizeTextHandler?

  init(
    orientation: CGImagePropertyOrientation,
    handler: RequestHandler,
    image: CIImage,
    recognizeTextHandler: RecognizeTextHandler?
  ) {
    self.orientation = orientation
    self.handler = handler
    self.image = image
    self.recognizeTextHandler = recognizeTextHandler
  }

  convenience init(_ arg: [String: Any]) throws {
    let bytes = arg["data"] as? FlutterStandardTypedData
    let width = arg["width"] as? Int ?? 0
    let height = arg["height"] as? Int ?? 0
    let orientation = arg["orientation"] as? String ?? "down"
    let handler = arg["handler"] as? String ?? "image"

    if bytes == nil {
      throw PluginError.invalidImageData
    }
    let data = Data(bytes!.data)
    if data.count != height * width * 4 {
      throw PluginError.invalidImageData
    }
    let size = CGSize(width: width, height: height)
    let image = CIImage(
      bitmapData: data,
      bytesPerRow: width * 4,
      size: size,
      format: CIFormat.RGBA8,
      colorSpace: nil
    )

    let recognizeTextHandler = arg["recognize_text"] as? [String: Any]

    self.init(
      orientation: Orientation(orientation).toCGImagePropertyOrientation(),
      handler: RequestHandler(handler),
      image: image,
      recognizeTextHandler: recognizeTextHandler == nil
        ? nil
        : RecognizeTextHandler(recognizeTextHandler!)
    )
  }
}
