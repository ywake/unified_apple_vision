import 'dart:async';

import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/src/utility/logger.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:uuid/uuid.dart';

import 'methods.dart';

typedef _UUID = String;

class AnalyzeApi {
  final Logger _logger;
  AnalyzeApi(this._logger);

  var analyzeMode = VisionAnalyzeMode.still;
  var executionPriority = VisionExecutionPriority.medium;
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

    try {
      Method.analyze.invoke({
        'image': image.toMap(),
        'priority': executionPriority.taskPriority,
        'mode': analyzeMode.modeName,
        'requests': [for (var req in mReqs) req.toMap()]
      });
    } catch (e) {
      rethrow;
    }

    for (final req in mReqs) {
      req.completer.future.then((data) {
        try {
          req.request.onResults(data);
        } catch (e, st) {
          _logger.e("Error VisionRequest.onResults", error: e, stackTrace: st);
        }
      });
    }
  }

  void onResults(Json json) {
    try {
      final isSuccess = json.bool_('is_success');
      if (isSuccess) {
        final data = _SuccessData.fromJson(json);
        final req = _requests.remove(data.requestId);
        if (req == null) return;
        final result = VisionResults.onSuccess(
          type: req.request.type,
          data: data.observations,
        );
        req.completer.complete(result);
      } else {
        final data = _FailureData.fromJson(json);
        if (data.requestId == null) return;
        final req = _requests.remove(data.requestId);
        if (req == null) return;
        final result = VisionResults.onFailure(data: json);
        req.completer.complete(result);
      }
    } catch (e, st) {
      _logger.e("Error on receiving results", error: e, stackTrace: st);
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
      ...request.toMap(),
    };
  }
}

class _SuccessData {
  final String requestId;
  final List<Json> observations;

  _SuccessData({
    required this.requestId,
    required this.observations,
  });

  factory _SuccessData.fromJson(Json json) {
    final requestId = json.str('request_id');
    final observations = json.jsonList('results');
    return _SuccessData(requestId: requestId, observations: observations);
  }
}

class _FailureData {
  final String? requestId;
  final String code;
  final String message;

  _FailureData({
    required this.requestId,
    required this.code,
    required this.message,
  });

  factory _FailureData.fromJson(Json json) {
    final error = json.json('error');
    return _FailureData(
      requestId: json.strOr('request_id'),
      code: error.str('code'),
      message: error.str('message'),
    );
  }
}
