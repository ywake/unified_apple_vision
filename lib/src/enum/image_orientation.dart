enum VisionImageOrientation {
  /// The encoded image data matches the image's intended display orientation.
  up,

  /// The encoded image data is horizontally flipped from the image's intended display orientation.
  upMirrored,

  /// The encoded image data is rotated 180° from the image's intended display orientation.
  down,

  /// The encoded image data is vertically flipped from the image's intended display orientation.
  downMirrored,

  /// The encoded image data is rotated 90° clockwise from the image's intended display orientation.
  left,

  /// The encoded image data is horizontally flipped and rotated 90° counter-clockwise from the image's intended display orientation.
  leftMirrored,

  /// The encoded image data is rotated 90° clockwise from the image's intended display orientation.
  right,

  /// The encoded image data is horizontally flipped and rotated 90° clockwise from the image's intended display orientation.
  rightMirrored,
  ;
}
