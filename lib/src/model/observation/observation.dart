import 'package:unified_apple_vision/src/utility/json.dart';

/// The superclass for analysis results.
///
/// Observations resulting from Vision image analysis requests inherit from this base class.
class VisionObservation {
  /// A unique identifier assigned to the Vision observation.
  final String uuid;

  /// The level of confidence in the observation’s accuracy.
  final double confidence;

  const VisionObservation({
    required this.uuid,
    required this.confidence,
  });

  VisionObservation.clone(VisionObservation other)
      : this(
          uuid: other.uuid,
          confidence: other.confidence,
        );

  factory VisionObservation.fromJson(Json json) {
    return VisionObservation(
      uuid: json.str('uuid'),
      confidence: json.double_('confidence'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'confidence': confidence,
    };
  }

  VisionObservation copyWith({
    String? uuid,
    double? confidence,
  }) {
    return VisionObservation(
      uuid: uuid ?? this.uuid,
      confidence: confidence ?? this.confidence,
    );
  }
}
