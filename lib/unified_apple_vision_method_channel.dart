import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'unified_apple_vision_platform_interface.dart';

/// An implementation of [UnifiedAppleVisionPlatform] that uses method channels.
class MethodChannelUnifiedAppleVision extends UnifiedAppleVisionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('unified_apple_vision');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
