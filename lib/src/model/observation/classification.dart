import 'observation.dart';

/// An object that represents classification information that an image analysis request produces.
///
/// This type of observation results from performing a [VNCoreMLRequest] image analysis with a Core ML model whose role is classification (rather than prediction or image-to-image processing). Vision infers that an [MLModel] object is a classifier model if that model predicts a single feature. That is, the model’s [modelDescription] object has a non-nil value for its [predictedFeatureName] property.
class VisionClassificationObservation extends VisionObservation {
  final String identifier;

  VisionClassificationObservation.withParent({
    required VisionObservation parent,
    required this.identifier,
  }) : super.clone(parent);

  VisionClassificationObservation.clone(VisionClassificationObservation other)
      : this.withParent(
          parent: other,
          identifier: other.identifier,
        );

  factory VisionClassificationObservation.fromMap(Map<String, dynamic> map) {
    final identifier = map['identifier'] as String?;
    if (identifier == null) {
      throw Exception('Failed to parse VisionClassificationObservation');
    }
    return VisionClassificationObservation.withParent(
      parent: VisionObservation.fromMap(map),
      identifier: identifier,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'identifier': identifier,
    };
  }
}
