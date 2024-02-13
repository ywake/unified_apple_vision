# unified_apple_vision 🍎

[![Pub Version](https://img.shields.io/pub/v/unified_apple_vision)](https://pub.dev/packages/unified_apple_vision)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

This plugin is for using [Apple Vision Framework](https://developer.apple.com/documentation/vision) with Flutter.

This plugin is designed to unify multiple APIs into one plugin and process multiple analysis requests at once.

## Features ⚙️
| Vision API |
|------------|
| [Text Recognition](https://developer.apple.com/documentation/vision/recognizing_text_in_images) |

## Requirements 🧩
* iOS 13.0+
* macOS 10.15+

## Install 📦
Add this to your pubspec.yaml:

```yaml
unified_apple_vision: ^latest
```

## Usage 🕹

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

### [Documents 📘](docs/README.md)

## License 📜
This project is licensed under the MIT License - see the [LICENSE](https://github.com/ywake/unified_apple_vision/blob/main/LICENSE) file for details.
