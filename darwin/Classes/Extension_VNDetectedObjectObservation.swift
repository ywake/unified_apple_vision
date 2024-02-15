import Foundation
import Vision

extension VNDetectedObjectObservation {
  @objc convenience init?(dict: [String: Any]?) {
    guard let dict = dict else { return nil }
    // boundingBox
    guard let boundingBox = dict["bounding_box"] as? [String: Any] else { return nil }
    guard let rect = CGRect(dict: boundingBox) else { return nil }
    self.init(boundingBox: rect)
  }

  @objc override func toDict() -> [String: Any] {
    // Convert the lower left origin to the upper left origin
    let newOrigin = CGPoint(
      x: self.boundingBox.origin.x,
      y: self.boundingBox.origin.y + self.boundingBox.size.height
        // y: 1 - self.boundingBox.origin.y - self.boundingBox.size.height
    )
    let boundingBox = CGRect(
      origin: newOrigin,
      size: self.boundingBox.size
    )
    return [
      "bounding_box": boundingBox.toDict()
    ].merging(super.toDict()) { (old, _) in old }
  }
}
