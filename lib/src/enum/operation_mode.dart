/// Specify whether to analyze a single still image or a continuous image sequence, such as a video frame.
enum VisionAnalyzeMode {
  /// Analyze a single still image.
  /// Processed using VNImageRequestHandler.
  still('image'),

  /// Analyze a continuous image sequence.
  /// Processed using VNSequenceRequestHandler.
  sequential('sequence'),
  ;

  final String modeName;
  const VisionAnalyzeMode(this.modeName);
}
