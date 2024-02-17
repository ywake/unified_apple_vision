# Documents 📘

> [!NOTE]
> Feedback and pull requests for this documentation are very welcome.

## 1. Create a `UnifiedAppleVision` instance
```dart
final vision = UnifiedAppleVision();
```

## 2. Set options

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



## 3. Start processing

You can analyze images by calling the `analyze` method.

```dart
// create input image
final input = VisionInputImage(
  bytes: image.bytes,
  size: image.size,
);

// analyze
final result = await vision.analyze(input, [
  // add requests you wish to perform
  const VisionRecognizeTextRequest(),
]);
```

For example, if you wish to perform text recognition, add `VisionRecognizeTextRequest()`.
