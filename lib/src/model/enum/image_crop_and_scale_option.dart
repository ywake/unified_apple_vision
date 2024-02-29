/// Options that define how Vision crops and scales an input-image.
///
/// Scaling an image ensures that it fits within the algorithm’s input image dimensions, which may require a change in aspect ratio. The figure below shows how each crop-and-scale option transforms the input image: <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
enum VisionImageCropAndScaleOption {
  /// An option that scales the image to fit its shorter side within the input dimensions, while preserving its aspect ratio, and center-crops the image.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  centerCrop,

  /// An option that scales the image to fit its longer side within the input dimensions, while preserving its aspect ratio, and center-crops the image.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFit,

  /// An option that scales the image to fill the input dimensions, resizing it if necessary.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFill,

  /// An option that rotates the image 90 degrees counterclockwise and then scales it, while preserving its aspect ratio, to fit on the long side.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFitRotate90CCW,

  /// An option that rotates the image 90 degrees counterclockwise and then scales it to fill the input dimensions.
  /// <img src="https://docs-assets.developer.apple.com/published/c509ace3cc/renderedDark2x-1670365971.png" width=95%>
  scaleFillRotate90CCW,
}
