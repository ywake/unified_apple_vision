import Foundation

enum QoS: String {
  case userInteractive = "userInteractive"
  case userInitiated = "userInitiated"
  case `default` = "default"
  case utility = "utility"
  case background = "background"
  case unspecified = "unspecified"

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
