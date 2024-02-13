enum RequestMode: String {
  case image = "image"
  case sequence = "sequence"

  init(_ rawValue: String) {
    switch rawValue {
    case "image": self = .image
    case "sequence": self = .sequence
    default: self = .image
    }
  }
}
