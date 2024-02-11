import 'package:flutter/services.dart';

import 'enum/execution_priority.dart';
import 'enum/image_orientation.dart';
import 'enum/method.dart';
import 'enum/operation_mode.dart';
import 'model/results.dart';
import 'option/recognize_text_option.dart';

class UnifiedAppleVision {
  final executionPriority = VisionExecutionPriority.veryHigh;
  final analyzeMode = VisionAnalyzeMode.oneByOne;
  VisionRecognizeTextOption? recognizeTextOption;

  UnifiedAppleVision();

  Future<VisionResults> analyze({
    required Uint8List bytes,
    required Size size,
    VisionImageOrientation orientation = VisionImageOrientation.up,
  }) async {
    final input = _buildInput(bytes, size, orientation);
    final results = await Method.analyze.invoke(input);
    if (results == null) {
      throw Exception('Failed to analyze');
    }
    return VisionResults.fromMap(results);
  }

  Future<List<String>> supportedRecognitionLanguages() async {
    final results = await Method.supportedRecognitionLanguages.invoke();
    if (results == null) {
      throw Exception('Failed to get supported recognition languages');
    }
    return [];
  }

  Map<String, dynamic> _buildInput(
    Uint8List bytes,
    Size size,
    VisionImageOrientation orientation,
  ) {
    return {
      'data': bytes,
      'width': size.width,
      'height': size.height,
      'orientation': orientation.name,
      'qos': executionPriority.qos,
      'handler': analyzeMode.handlerName,
      if (recognizeTextOption != null) 'recognize_text': recognizeTextOption!.toMap(),
    };
  }
}
