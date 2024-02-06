import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unified_apple_vision/unified_apple_vision_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUnifiedAppleVision platform = MethodChannelUnifiedAppleVision();
  const MethodChannel channel = MethodChannel('unified_apple_vision');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
