import Foundation

enum QoS: String {
  case userInteractive = "userInteractive"
  case userInitiated = "userInitiated"
  case `default` = "default"
  case utility = "utility"
  case background = "background"
  case unspecified = "unspecified"

  init(_ rawValue: String) {
    switch rawValue {
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

  func toDispatchQoS() -> DispatchQoS.QoSClass {
    switch self {
    case .userInteractive:
      return .userInteractive
    case .userInitiated:
      return .userInitiated
    case .default:
      return .default
    case .utility:
      return .utility
    case .background:
      return .background
    case .unspecified:
      return .unspecified
    }
  }
}
