import 'package:unified_apple_vision/src/extension/list.dart';

import 'classification.dart';
import 'detected_object.dart';

/// A detected object observation with an array of classification labels that classify the recognized object.
///
/// The confidence of the classifications sum up to 1.0. Multiply the classification confidence with the confidence of this observation.
class VisionRecognizedObjectObservation
    extends VisionDetectedObjectObservation {
  /// An array of observations that classify the recognized object.
  final List<VisionClassificationObservation> labels;

  VisionRecognizedObjectObservation.withParent({
    required VisionDetectedObjectObservation parent,
    required this.labels,
  }) : super.clone(parent);

  VisionRecognizedObjectObservation.clone(
      VisionRecognizedObjectObservation other)
      : this.withParent(
          parent: other,
          labels: other.labels,
        );

  factory VisionRecognizedObjectObservation.fromMap(Map<String, dynamic> map) {
    final labels = (map['labels'] as List?)?.castMap();
    if (labels == null) {
      throw Exception('Failed to parse VisionRecognizedObjectObservation');
    }

    return VisionRecognizedObjectObservation.withParent(
      parent: VisionDetectedObjectObservation.fromMap(map),
      labels: [
        for (final label in labels)
          VisionClassificationObservation.fromMap(label),
      ],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'labels': [for (final label in labels) label.toMap()],
    };
  }
}
