import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:uuid/uuid.dart';

import 'api.dart';
import 'model/request/request.dart';
import 'utility/json.dart';

typedef _UUID = String;

class UnifiedAppleVision {
  /// Log level displayed in xcode.
  var xcodeLogLevel = VisionLogLevel.none;

  /// Priority of the task that performs the analysis.
  var executionPriority = VisionExecutionPriority.unspecified;

  /// Specify whether to analyze a single still image or a continuous image sequence, such as a video frame.
  var analyzeMode = VisionAnalyzeMode.still;

  UnifiedAppleVision() {
    Method.channel.setMethodCallHandler(_methodCallHandler);
  }

  final _requests = <_UUID, _ManagingRequest>{};

  Future<void> analyze({
    required VisionInputImage image,
    required List<VisionRequest> requests,
  }) async {
    // If there are no requests, no analysis is performed.
    if (requests.isEmpty) return;

    final mReqs = [for (var req in requests) _ManagingRequest(req)];
    for (var req in mReqs) {
      _requests[req.requestId] = req;
    }

    Method.analyze.invoke(xcodeLogLevel, {
      'image': image.toMap(),
      'qos': executionPriority.qos,
      'mode': analyzeMode.modeName,
      'requests': [
        for (var req in mReqs)
          {
            "request_id": req.requestId,
            ...req.request.encode(),
          },
      ]
    });

    for (final req in mReqs) {
      req.completer.future.then((data) {
        try {
          req.request.onResults(data);
        } catch (e, st) {
          debugPrint('error: $e');
          debugPrint('stacktrace: $st');
        }
      });
    }
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'response':
        _onResponse(call.arguments);
        break;
      default:
        throw UnimplementedError();
    }
  }

  void _onResponse(dynamic arguments) {
    try {
      final json = Json.fromString(arguments.toString());
      final input = ResponseApi.fromJson(json);
      final req = _requests.remove(input.requestId);
      if (req != null) {
        final result = VisionResults.fromJsonList(
          type: req.request.type,
          data: input.observations,
        );
        req.completer.complete(result);
      }
    } catch (e, st) {
      debugPrint('error: $e');
      debugPrint('stacktrace: $st');
    }
  }

  // Future<List<Locale>?> supportedRecognitionLanguages([
  //   VisionTextRecognitionLevel recognitionLevel =
  //       VisionTextRecognitionLevel.accurate,
  // ]) async {
  //   final results =
  //       await Method.supportedRecognitionLanguages.invoke(xcodeLogLevel, {
  //     'recognition_level': recognitionLevel.name,
  //   });
  //   if (results == null) {
  //     throw Exception('Failed to get supported recognition languages');
  //   }
  //   final languages = results['supported_recognition_languages'] as List?;
  //   return languages?.map((e) {
  //     final [lang, country] = (e as String).split('-');
  //     return Locale(lang, country);
  //   }).toList();
  // }
}

class _ManagingRequest {
  static const _uuid = Uuid();

  final _UUID requestId;
  final VisionRequest request;
  final Completer<VisionResults> completer;

  _ManagingRequest(this.request)
      : requestId = _uuid.v7(),
        completer = Completer();
}
