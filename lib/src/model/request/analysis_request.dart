import 'package:unified_apple_vision/src/enum/analysis_type.dart';

abstract class AnalysisRequest {
  final AnalysisType type;

  const AnalysisRequest({required this.type});

  Map<String, dynamic> toRequestMap() {
    final map = toMap();
    if (map.containsKey('request_type')) {
      throw Exception('The key "request_type" is reserved');
    }

    return {
      'request_type': type.key,
      ...map,
    };
  }

  Map<String, dynamic> toMap();
}
