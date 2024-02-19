import Foundation

extension CGRect {
  init?(dict: [String: Any]?) {
    guard let dict = dict else { return nil }

    let originMap = dict["origin"] as? [String: Any]
    let sizeMap = dict["size"] as? [String: Any]
    guard let originMap = originMap, let sizeMap = sizeMap else {
      return nil
    }

    let origin = CGPoint(dict: originMap)
    let size = CGSize(dict: sizeMap)
    guard let origin = origin, let size = size else { return nil }

    self.init(origin: origin, size: size)
  }

  init(json: Json) throws {
    let origin = try json.json("origin")
    let size = try json.json("size")
    self.init(
      origin: try CGPoint(json: origin),
      size: try CGSize(json: size)
    )
  }

  func toDict() -> [String: Any] {
    return [
      "origin": origin.toDict(),
      "size": size.toDict(),
    ]
  }
}
