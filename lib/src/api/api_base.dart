import 'dart:async';

import 'package:unified_apple_vision/src/enum/execution_priority.dart';
import 'package:unified_apple_vision/src/utility/json.dart';
import 'package:unified_apple_vision/src/utility/logger.dart';
import 'package:unified_apple_vision/src/utility/unique_id.dart';

import 'methods.dart';

typedef ReturnType = (bool isSuccess, Json json);

abstract class OneToOneApi {
  final Logger _logger;
  final Method _method;
  OneToOneApi({
    required Logger logger,
    required Method method,
  })  : _logger = logger,
        _method = method;

  final _completers = <UniqueId, Completer<ReturnType>>{};

  Future<ReturnType> invoke({
    required VisionExecutionPriority priority,
    Map<String, dynamic>? arg,
  }) {
    final completer = Completer<ReturnType>();
    final id = UniqueId.gen();
    _completers[id] = completer;
    try {
      _method.invoke(priority, {
        'request_id': id.toString(),
        ...?arg,
      });
    } catch (e) {
      rethrow;
    }
    return completer.future;
  }

  void onResults(Json json) {
    const funcName = 'ApiBase>onResults';
    _logger.d('onResults: $json', funcName);
    try {
      final id = json.str('request_id');
      final completer = _completers.remove(UniqueId(id));
      if (completer != null) {
        completer.complete((json.bool_('is_success'), json.json('results')));
      } else {
        throw StateError('No request found for response: $json');
      }
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
