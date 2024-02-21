import Foundation

extension DispatchQoS.QoSClass {
  init(byNameOr name: String?) {
    switch name {
    case "userInteractive":
      self = .userInteractive
    case "userInitiated":
      self = .userInitiated
    case "default":
      self = .default
    case "utility":
      self = .utility
    case "background":
      self = .background
    case "unspecified":
      self = .unspecified
    default:
      self = .unspecified
    }
  }
}
