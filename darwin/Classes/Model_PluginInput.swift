import CoreImage
import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

class PluginInput {
  let image: InputImage
  let handler: RequestHandler
  let recognizeTextHandler: RecognizeTextHandler?

  init(
    image: InputImage,
    handler: RequestHandler,
    recognizeTextHandler: RecognizeTextHandler?
  ) {
    self.image = image
    self.handler = handler
    self.recognizeTextHandler = recognizeTextHandler
  }

  convenience init(_ arg: [String: Any]) throws {
    let image = try InputImage(arg["image"] as? [String: Any])
    let handler = arg["handler"] as? String ?? "image"

    let recognizeTextOption = arg["recognize_text"] as? [String: Any]

    self.init(
      image: image,
      handler: RequestHandler(handler),
      recognizeTextHandler: RecognizeTextHandler(recognizeTextOption)
    )
  }
}
