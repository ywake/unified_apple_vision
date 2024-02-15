import 'dart:ui';

import 'package:unified_apple_vision/src/extension/map.dart';
import 'package:unified_apple_vision/src/extension/rect.dart';

import 'observation.dart';

class VisionDetectedObjectObservation extends VisionObservation {
  final Rect boundingBox;

  // const VisionDetectedObjectObservation({
  //   required this.boundingBox,
  //   required super.uuid,
  //   required super.confidence,
  // });

  VisionDetectedObjectObservation.withParent({
    required this.boundingBox,
    required VisionObservation parent,
  }) : super(
          uuid: parent.uuid,
          confidence: parent.confidence,
        );

  factory VisionDetectedObjectObservation.fromMap(Map<String, dynamic> map) {
    final boundingBox = map['bounding_box'] as Map?;
    if (boundingBox == null) {
      throw Exception('Failed to parse VisionDetectedObjectObservation');
    }
    return VisionDetectedObjectObservation.withParent(
      parent: VisionObservation.fromMap(map),
      boundingBox: RectEx.fromMap(boundingBox.castEx()),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'bounding_box': boundingBox.toMap(),
    };
  }

  @override
  VisionDetectedObjectObservation copyWith({
    Rect? boundingBox,
    String? uuid,
    double? confidence,
  }) {
    return VisionDetectedObjectObservation.withParent(
      boundingBox: boundingBox ?? this.boundingBox,
      parent: super.copyWith(
        uuid: uuid,
        confidence: confidence,
      ),
    );
  }
}
