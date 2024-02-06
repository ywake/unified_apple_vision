import 'package:flutter_test/flutter_test.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:unified_apple_vision/unified_apple_vision_platform_interface.dart';
import 'package:unified_apple_vision/unified_apple_vision_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUnifiedAppleVisionPlatform
    with MockPlatformInterfaceMixin
    implements UnifiedAppleVisionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UnifiedAppleVisionPlatform initialPlatform = UnifiedAppleVisionPlatform.instance;

  test('$MethodChannelUnifiedAppleVision is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUnifiedAppleVision>());
  });

  test('getPlatformVersion', () async {
    UnifiedAppleVision unifiedAppleVisionPlugin = UnifiedAppleVision();
    MockUnifiedAppleVisionPlatform fakePlatform = MockUnifiedAppleVisionPlatform();
    UnifiedAppleVisionPlatform.instance = fakePlatform;

    expect(await unifiedAppleVisionPlugin.getPlatformVersion(), '42');
  });
}
