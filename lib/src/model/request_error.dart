import 'package:unified_apple_vision/src/utility/json.dart';

class VisionRequestError {
  final String code;
  final String message;

  VisionRequestError({
    required this.code,
    required this.message,
  });

  factory VisionRequestError.fromJson(Json json) {
    return VisionRequestError(
      code: json.str('code'),
      message: json.str('message'),
    );
  }
}
