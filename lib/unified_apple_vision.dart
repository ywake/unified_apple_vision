
import 'unified_apple_vision_platform_interface.dart';

class UnifiedAppleVision {
  Future<String?> getPlatformVersion() {
    return UnifiedAppleVisionPlatform.instance.getPlatformVersion();
  }
}
