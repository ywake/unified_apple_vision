import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/rectangle.dart';

import 'image_based.dart';

/// **iOS 11.0+, macOS 10.13+**
///
/// An image analysis request that finds projected rectangular regions in an image.
///
/// A rectangle detection request locates regions of an image with rectangular shape, like credit cards, business cards, documents, and signs. The request returns its observations in the form of [VisionRectangleObservation] objects, which contain normalized coordinates of bounding boxes containing the rectangle.
///
/// Use this type of request to find the bounding boxes of rectangles in an image. Vision returns observations for rectangles found in all orientations and sizes, along with a confidence level to indicate how likely it’s that the observation contains an actual rectangle.
///
/// To further configure or restrict the types of rectangles found, set properties on the request specifying a range of aspect ratios, sizes, and quadrature to5lerance.
///
class VisionDetectRectanglesRequest extends VisionImageBasedRequest {
  /// A double specifying the minimum aspect ratio of the rectangle to detect, defined as the shorter dimension over the longer dimension.
  /// The value should range from 0.0 to 1.0, inclusive. The default value is 0.5.
  final double? minAspectRatio;

  /// A double specifying the maximum aspect ratio of the rectangle to detect, defined as the shorter dimension over the longer dimension.
  /// The value should range from 0.0 to 1.0, inclusive. The default value is 0.5.
  final double? maxAspectRatio;

  /// A double specifying the number of degrees a rectangle corner angle can deviate from 90°.
  /// The tolerance value should range from 0 to 45, inclusive. The default tolerance is 30.
  final double? quadratureTolerance;

  /// The minimum size of a rectangle to detect, as a proportion of the smallest dimension.
  /// The value should range from 0.0 to 1.0 inclusive. The default minimum size is 0.2.
  /// Any smaller rectangles that Vision may have detected aren’t returned.
  final double? minSize;

  /// A value specifying the minimum acceptable confidence level.
  /// Vision won’t return rectangles with a confidence score lower than the specified minimum.
  /// The confidence score ranges from 0.0 to 1.0, inclusive, where 0.0 represents no confidence, and 1.0 represents full confidence.
  final double? minConfidence;

  /// An integer specifying the maximum number of rectangles Vision returns.
  /// The default value is 1.
  /// Setting this property to 0 allows Vision algorithms to return an unlimited number of observations.
  final int? maxObservations;

  const VisionDetectRectanglesRequest({
    this.minAspectRatio,
    this.maxAspectRatio,
    this.quadratureTolerance,
    this.minSize,
    this.minConfidence,
    this.maxObservations,
    super.regionOfInterest,
    required super.onResults,
  })  : assert(
          minAspectRatio == null || 0 <= minAspectRatio && minAspectRatio <= 1,
          'The aspect ratio should range from 0 to 1, inclusive.',
        ),
        assert(
          maxAspectRatio == null || 0 <= maxAspectRatio && maxAspectRatio <= 1,
          'The aspect ratio should range from 0 to 1, inclusive.',
        ),
        assert(
          quadratureTolerance == null ||
              0 <= quadratureTolerance && quadratureTolerance <= 45,
          'The tolerance value should range from 0 to 45, inclusive.',
        ),
        assert(
          minSize == null || 0 <= minSize && minSize <= 1,
          'The minimum size should range from 0 to 1, inclusive.',
        ),
        super(type: VisionRequestType.detectRectangles);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'min_aspect_ratio': minAspectRatio,
      'max_aspect_ratio': maxAspectRatio,
      'quadrature_tolerance': quadratureTolerance,
      'min_size': minSize,
      'min_confidence': minConfidence,
      'max_observations': maxObservations,
    };
  }
}
