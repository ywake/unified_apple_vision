import 'dart:async';

import 'package:flutter/services.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'api/analyze.dart';
import 'api/methods.dart';
import 'utility/json.dart';

class UnifiedAppleVision {
  UnifiedAppleVision() {
    Method.channel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    final method = Method.values.byName(call.method);
    final json = Json.fromResponse(call.arguments);
    switch (method) {
      case Method.analyze:
        _analyzeApi.onResults(json);
      default:
        throw UnimplementedError('Response method $method is not implemented');
    }
  }

  ///
  /// Analyze API
  ///
  final _analyzeApi = AnalyzeApi();

  /// Specify whether to analyze a single still image or a continuous image sequence, such as a video frame.
  set analyzeMode(VisionAnalyzeMode mode) {
    _analyzeApi.analyzeMode = mode;
  }

  /// Priority of the task that performs the analysis.
  set executionPriority(VisionExecutionPriority priority) {
    _analyzeApi.executionPriority = priority;
  }

  Future<void> analyze({
    required VisionInputImage image,
    required List<VisionRequest> requests,
  }) async {
    await _analyzeApi.execute(image: image, requests: requests);
  }

  ///
  /// setLogLevel
  ///

  /// Set the log level for Unified Apple Vision.
  Future<void> setLogLevel(VisionLogLevel level) async {
    await Method.setLogLevel.invoke({'log_level': level.name});
  }
}
