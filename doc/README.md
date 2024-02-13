# Documents 📘

> [!NOTE]
> Feedback and pull requests for this documentation are very welcome.

## 1. Create a `UnifiedAppleVision` instance
```dart
final vision = UnifiedAppleVision();
```

## 2. Set options

### Overall setting

```dart
vision.executionPriority = VisionExecutionPriority.veryHigh;
vision.analyzeMode = VisionAnalyzeMode.still;
```
The priority and mode of analysis processing can be set.

> [!NOTE]
> ### About Analysis Processing Modes
>
> There are two modes of analysis processing.
>
> | Mode | Description |
> |------|-------------|
> | `.still` | Suitable for analyzing still images one by one. |
> | `.sequential` | It is suitable for analyzing a series of images, such as a video.<br>The results of the analysis of the previous image are used for the next analysis.<br>Suitable for object tracking, etc. |

### Add a request for the analysis you wish to perform

```dart
vision.request = [const VisionRecognizeTextRequest()];
```

For example, if you wish to perform text recognition, add `VisionRecognizeTextRequest` to the `request` property.

## 3. Start processing

```dart
final inputImage = VisionInputImage(
  bytes: image.bytes,
  size: image.size,
);
final result = await vision.analyze(inputImage);
```

You can analyze images by calling the `analyze` method.