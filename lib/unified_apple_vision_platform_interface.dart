import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'unified_apple_vision_method_channel.dart';

abstract class UnifiedAppleVisionPlatform extends PlatformInterface {
  /// Constructs a UnifiedAppleVisionPlatform.
  UnifiedAppleVisionPlatform() : super(token: _token);

  static final Object _token = Object();

  static UnifiedAppleVisionPlatform _instance = MethodChannelUnifiedAppleVision();

  /// The default instance of [UnifiedAppleVisionPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnifiedAppleVision].
  static UnifiedAppleVisionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UnifiedAppleVisionPlatform] when
  /// they register themselves.
  static set instance(UnifiedAppleVisionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
