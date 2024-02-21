import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:uuid/uuid.dart';

import 'methods.dart';

typedef _UUID = String;

class AnalyzeApi {
  var analyzeMode = VisionAnalyzeMode.still;
  var executionPriority = VisionExecutionPriority.unspecified;
  final _requests = <_UUID, _ManagingRequest>{};

  Future<void> execute({
    required VisionInputImage image,
    required List<VisionRequest> requests,
  }) async {
    // If there are no requests, no analysis is performed.
    if (requests.isEmpty) return;

    final mReqs = [for (var req in requests) _ManagingRequest(req)];
    for (var req in mReqs) {
      _requests[req.requestId] = req;
    }

    Method.analyze.invoke({
      'image': image.toMap(),
      'qos': executionPriority.qos,
      'mode': analyzeMode.modeName,
      'requests': [for (var req in mReqs) req.toMap()]
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

  void onResults(Json json) {
    try {
      // final json = Json.fromString(arguments.toString());
      final data = _ResponseData.fromJson(json);
      final req = _requests.remove(data.requestId);
      if (req != null) {
        final result = VisionResults.fromJsonList(
          type: req.request.type,
          data: data.observations,
        );
        req.completer.complete(result);
      }
    } catch (e, st) {
      debugPrint('error: $e');
      debugPrint('stacktrace: $st');
    }
  }
}

class _ManagingRequest {
  static const _uuid = Uuid();

  final _UUID requestId;
  final VisionRequest request;
  final Completer<VisionResults> completer;

  _ManagingRequest(this.request)
      : requestId = _uuid.v7(),
        completer = Completer();

  Map<String, dynamic> toMap() {
    return {
      'request_id': requestId,
      ...request.encode(),
    };
  }
}

class _ResponseData {
  final String requestId;
  final List<Json> observations;

  _ResponseData({
    required this.requestId,
    required this.observations,
  });

  factory _ResponseData.fromJson(Json json) {
    final requestId = json.str('request_id');
    final observations = json.jsonList('results');
    return _ResponseData(requestId: requestId, observations: observations);
  }
}
