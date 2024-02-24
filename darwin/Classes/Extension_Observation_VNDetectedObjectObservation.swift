import Foundation
import Vision

@available(iOS 11.0, macOS 10.13, *)
extension VNDetectedObjectObservation {
  // NOTE: These cannot be overridden by VNRectangleObservation.
  // convenience init(json: Json) throws {}
  // @objc convenience init(json: Json) throws {}
  // static func fromJson(_ json: Json) throws -> VNDetectedObjectObservation {}

  // So the argument should be Dict so that @objc can be added
  @objc convenience init(dict: [String: Any]) throws {
    let json = Json(dict)
    let boundingBox = try json.json("bounding_box")
    let rect = try CGRect(json: boundingBox)
    self.init(boundingBox: rect)
  }

  @objc override func toDict() -> [String: Any] {
    return [
      "bounding_box": self.boundingBox.toDict()
    ] + super.toDict()
  }
}
