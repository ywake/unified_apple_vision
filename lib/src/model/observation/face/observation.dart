import 'package:unified_apple_vision/src/model/observation/detected_object.dart';
import 'package:unified_apple_vision/src/model/request/detect_face_rectangles.dart';
import 'package:unified_apple_vision/src/utility/json.dart';

import 'landmarks_2d.dart';

/// Face or facial-feature information that an image analysis request detects.
///
/// This type of observation results from a VNDetectFaceRectanglesRequest. It contains information about facial landmarks and regions it finds in the image.
class VisionFaceObservation extends VisionDetectedObjectObservation {
  /// The facial features of the detected face.
  ///
  /// This value is nil for face observations produced by a [VisionDetectFaceRectanglesRequest] analysis. Use the [VisionDetectFaceLandmarksRequest] class to find facial features.
  final VisionFaceLandmarks2D? landmarks;

  /// **iOS 12.0+, macOS 10.14+**
  /// This value indicates the rotational angle of the face around the z-axis.
  ///
  /// If the request doesn’t calculate the angle, the value is nil.
  final double? yaw;

  /// **iOS 12.0+, macOS 10.14+**
  /// This value indicates the rotational angle of the face around the y-axis.
  ///
  /// If the request doesn’t calculate the angle, the value is nil.
  final double? roll;

  /// **iOS 12.0+, macOS 10.14+**
  /// This value indicates the rotational angle of the face around the x-axis.
  ///
  /// If the request doesn’t calculate the angle, the value is nil.
  final double? pitch;

  /// **iOS 13.0+, macOS 10.15+**
  /// A value that indicates the quality of the face capture.
  ///
  /// The capture quality of the face allows you to compare the quality of the face in terms of its capture attributes: lighting, blur, and prime positioning. Use this value to compare the capture quality of a face against other captures of the same face in a specified set.
  ///
  /// The value of this property value ranges from 0.0 to 1.0. Faces with quality closer to 1.0 are better lit, sharper, and more centrally positioned than faces with quality closer to 0.0.
  final double? faceCaptureQuality;

  VisionFaceObservation.withParent({
    required VisionDetectedObjectObservation parent,
    this.landmarks,
    this.yaw,
    this.roll,
    this.pitch,
    this.faceCaptureQuality,
  }) : super.clone(parent);

  VisionFaceObservation.clone(VisionFaceObservation other)
      : this.withParent(
          parent: other,
          landmarks: other.landmarks,
          yaw: other.yaw,
          roll: other.roll,
          pitch: other.pitch,
          faceCaptureQuality: other.faceCaptureQuality,
        );

  factory VisionFaceObservation.fromJson(Json json) {
    return VisionFaceObservation.withParent(
      parent: VisionDetectedObjectObservation.fromJson(json),
      landmarks: json.objOr('landmarks', VisionFaceLandmarks2D.fromJson),
      yaw: json.doubleOr('yaw'),
      roll: json.doubleOr('roll'),
      pitch: json.doubleOr('pitch'),
      faceCaptureQuality: json.doubleOr('faceCaptureQuality'),
    );
  }
}
