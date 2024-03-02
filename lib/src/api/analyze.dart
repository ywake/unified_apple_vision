import 'dart:async';

import 'package:unified_apple_vision/src/utility/unique_id.dart';
import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/src/utility/logger.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'methods.dart';

class AnalyzeApi {
  final Logger _logger;
  AnalyzeApi(this._logger);

  var analyzeMode = VisionAnalyzeMode.still;
  var executionPriority = VisionExecutionPriority.medium;
  final _requests = <UniqueId, _ManagingRequest>{};

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
          if (data.isSuccess) {
            final results = VisionResults.fromJsonList(
              type: req.request.type,
              data: data.observations!,
            );
            req.request.onResults(results);
          } else {
            final error = VisionRequestError.fromJson(data.error!);
            if (req.request.onError != null) {
              req.request.onError!(error);
            }
          }
        } on JsonException catch (e, st) {
          _logger.e(
            "Error VisionRequest.onResults",
            error: e,
            stackTrace: st,
            symbol: '${req.request.type}>${req.requestId}>then',
          );
        } catch (e) {
          rethrow;
        }
      });
    }
  }

  void onResults(Json json) {
    const funcName = 'onResults';
    _logger.d('$json', funcName);

    try {
      final data = _ReceivedData.fromJson(json);
      final req = _requests.remove(data.requestId);
      if (req == null) {
        throw Exception("Request not found. ${data.requestId}");
      }
      req.completer.complete(data);
    } catch (e, st) {
      _logger.e(
        "Error on receiving results",
        error: e,
        stackTrace: st,
        symbol: funcName,
      );
    }
  }
}

class _ManagingRequest {
  final UniqueId requestId;
  final VisionRequest request;
  final Completer<_ReceivedData> completer;

  _ManagingRequest(this.request)
      : requestId = UniqueId.gen(),
        completer = Completer();

  Map<String, dynamic> toMap() {
    return {
      'request_id': requestId.toString(),
      ...request.toMap(),
    };
  }
}

class _ReceivedData {
  final UniqueId requestId;
  final bool isSuccess;
  final List<Json>? observations;
  final Json? error;

  _ReceivedData({
    required this.requestId,
    required this.isSuccess,
    this.observations,
    this.error,
  }) : assert(isSuccess ? observations != null : error != null);

  factory _ReceivedData.fromJson(Json json) {
    final isSuccess = json.bool_('is_success');
    return _ReceivedData(
      requestId: UniqueId(json.str('request_id')),
      isSuccess: isSuccess,
      observations: isSuccess ? json.jsonList('results') : null,
      error: isSuccess ? null : json.json('error'),
    );
  }
}
