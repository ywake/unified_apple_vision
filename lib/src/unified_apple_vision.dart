import 'dart:ui';

import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'enum/method.dart';

class UnifiedAppleVision {
  var xcodeLogLevel = VisionLogLevel.none;
  var executionPriority = VisionExecutionPriority.unspecified;
  var analyzeMode = VisionAnalyzeMode.oneByOne;
  VisionRecognizeTextOption? recognizeTextOption;

  UnifiedAppleVision();

  Future<VisionResults> analyze(VisionInputImage image) async {
    final results = await Method.analyze.invoke(xcodeLogLevel, {
      'image': image.toMap(),
      'qos': executionPriority.qos,
      'handler': analyzeMode.handlerName,
      if (recognizeTextOption != null) 'recognize_text': recognizeTextOption!.toMap(),
    });
    if (results == null) {
      throw Exception('Failed to analyze');
    }
    return VisionResults.fromMap(image, results);
  }

  Future<List<Locale>?> supportedRecognitionLanguages([
    VisionTextRecognitionLevel recognitionLevel = VisionTextRecognitionLevel.accurate,
  ]) async {
    if (recognizeTextOption == null) {
      throw Exception('recognizeTextOption is needed to get supported recognition languages');
    }

    final results = await Method.supportedRecognitionLanguages.invoke(xcodeLogLevel, {
      'recognition_level': recognitionLevel.name,
    });
    if (results == null) {
      throw Exception('Failed to get supported recognition languages');
    }
    final languages = results['supported_recognition_languages'] as List?;
    return languages?.map((e) {
      final [lang, country] = (e as String).split('-');
      return Locale(lang, country);
    }).toList();
  }
}
