import 'dart:async';

import 'package:unified_apple_vision/src/utility/logger.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'api_base.dart';
import 'methods.dart';

class CoreMLApi extends OneToOneApi {
  CoreMLApi(Logger logger)
      : super(
          method: Method.coreML,
          logger: logger,
        );

  Future<String> compileModel(
    String modelPath,
    VisionExecutionPriority priority,
  ) async {
    final (isSuccess, json) = await invoke(priority: priority, arg: {
      'model_path': modelPath,
    });
    if (isSuccess) {
      return json.str('compiled_model_path');
    } else {
      throw StateError('Failed to compile model: $json');
    }
  }
}
