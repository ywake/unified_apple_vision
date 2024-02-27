import 'dart:async';

import 'package:flutter/services.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'api/analyze.dart';
import 'api/logging.dart';
import 'api/methods.dart';
import 'utility/json.dart';
import 'utility/logger.dart';

class UnifiedAppleVision {
  static final _logger = Logger();

  UnifiedAppleVision() {
    Method.channel.setMethodCallHandler(_methodCallHandler);
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    final method = Method.values.byName(call.method);
    try {
      final json = Json.fromString(call.arguments.toString());
      switch (method) {
        case Method.analyze:
          _analyzeApi.onResults(json);
          break;
        case Method.logging:
          _loggingApi.onResults(json);
          break;
      }
    } catch (e, st) {
      _logger.e("Failed to handle method call: $call",
          error: e, stackTrace: st);
      return;
    }
  }

  ///
  /// Analyze API
  ///
  final _analyzeApi = AnalyzeApi(_logger);

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
    try {
      await _analyzeApi.execute(image: image, requests: requests);
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// setLogLevel
  ///
  final _loggingApi = LoggingApi(_logger);

  /// Set the log level for Unified Apple Vision.
  Future<void> setLogLevel(VisionLogLevel level) async {
    try {
      await _loggingApi.setLogLevel(level);
    } catch (e) {
      rethrow;
    }
  }
}
