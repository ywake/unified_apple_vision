import Vision

extension VNRequestFaceLandmarksConstellation {
  init(_ value: String) {
    switch value {
    case "constellation65Points": self = .constellation65Points
    case "constellation76Points": self = .constellation76Points
    default: self = .constellationNotDefined
    }
  }
}
