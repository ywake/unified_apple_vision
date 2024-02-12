# unified_apple_vision

This plugin is for using [Apple Vision Framework](https://developer.apple.com/documentation/vision) with Flutter.

This plugin is designed to unify multiple APIs into one plugin and process multiple analysis requests at once.

## Features
* [x] Text Recognition

## Requirements
* iOS 13.0+
* macOS 10.15+

## Install
Add this to your pubspec.yaml:

```yaml
unified_apple_vision: ^latest
```

## Usage

```dart
// config
final vision = UnifiedAppleVision()
  ..executionPriority = VisionExecutionPriority.veryHigh
  ..recognizeTextOption = const VisionRecognizeTextOption(
    automaticallyDetectsLanguage: true,
  );

// analyze
final res = await vision.analyze(VisionInputImage(
  bytes: image.bytes,
  size: image.size,
));
```
