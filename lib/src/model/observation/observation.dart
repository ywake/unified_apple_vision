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

  factory VisionObservation.fromMap(Map<String, dynamic> map) {
    final uuid = map['uuid'] as String?;
    final confidence = map['confidence'] as double?;
    if (uuid == null || confidence == null) {
      throw Exception('Failed to parse VisionObservation');
    }
    return VisionObservation(
      uuid: uuid,
      confidence: confidence,
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
