/// Specify whether to analyze a single still image or a continuous image sequence, such as a video frame.
enum VisionAnalyzeMode {
  /// Analyze a single still image.
  /// Processed using VNImageRequestHandler.
  oneByOne,

  /// Analyze a continuous image sequence.
  /// Processed using VNSequenceRequestHandler.
  sequential,
  ;

  String get handlerName {
    switch (this) {
      case VisionAnalyzeMode.oneByOne:
        return 'image';
      case VisionAnalyzeMode.sequential:
        return 'sequence';
    }
  }
}
