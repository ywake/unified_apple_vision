import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';
import 'package:unified_apple_vision_example/extension/vision_classification_observation.dart';
import 'package:unified_apple_vision_example/extension/vision_recognized_text_observation.dart';
import 'package:unified_apple_vision_example/extension/vision_rectangle_observation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _unifiedAppleVision = UnifiedAppleVision()
    ..analyzeMode = VisionAnalyzeMode.still
    ..executionPriority = VisionExecutionPriority.veryHigh
    ..xcodeLogLevel = VisionLogLevel.none;

  VisionResults? results;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final supportedLangs =
        await _unifiedAppleVision.supportedRecognitionLanguages();
    debugPrint('supportedLangs: $supportedLangs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraAwesomeBuilder.awesome(
            saveConfig: SaveConfig.photo(),
            imageAnalysisConfig: AnalysisConfig(maxFramesPerSecond: 1),
            onImageForAnalysis: (image) async {
              image.when(
                bgra8888: (image) {
                  final input = VisionInputImage(
                    bytes: image.bytes,
                    size: image.size,
                  );
                  try {
                    final start = DateTime.now();
                    _unifiedAppleVision.analyze(input, [
                      const VisionRecognizeTextRequest(),
                      const VisionDetectRectanglesRequest(maxObservations: 0),
                      const VisionRecognizeAnimalsRequest(),
                    ]).then((res) {
                      final end = DateTime.now();
                      debugPrint('${end.difference(start).inMilliseconds}ms');
                      setState(() => results = res);
                    });
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
              );
            },
          ),
          ...[
            if (results?.recognizedText != null)
              for (final text in results!.recognizedText!) text.build(),
            if (results?.detectedRectangles != null)
              for (final rect in results!.detectedRectangles!) rect.build(),
            if (results?.recognizedAnimals != null)
              for (final animal in results!.recognizedAnimals!) animal.build(),
          ]
        ],
      ),
    );
  }
}
