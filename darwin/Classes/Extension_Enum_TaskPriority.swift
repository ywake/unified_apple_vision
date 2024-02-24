extension TaskPriority {
  init(byNameOr name: String?) {
    switch name {
    case "high": self = .high
    case "medium": self = .medium
    case "low": self = .low
    case "lowest": self = .background
    default:
      Logger.w("TaskPriority: unknown name: \(name ?? "nil"), using medium as default.")
      self = .medium
    }
  }
}
