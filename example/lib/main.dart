import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'extension/vision_barcode_observation.dart';
import 'extension/vision_classification_observation.dart';
import 'extension/vision_recognized_text_observation.dart';
import 'extension/vision_rectangle_observation.dart';
import 'extension/vision_text_observation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _unifiedAppleVision = UnifiedAppleVision()
    ..executionPriority = VisionExecutionPriority.veryHigh;

  List<VisionRecognizedTextObservation>? recognizedTexts;
  List<VisionRectangleObservation>? detectedRectangles;
  List<VisionRecognizedObjectObservation>? recognizedAnimals;
  List<VisionTextObservation>? detectedTextRectangles;
  List<VisionBarcodeObservation>? detectedBarcodes;

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
                    _unifiedAppleVision.analyze(
                      image: input,
                      requests: [
                        VisionDetectTextRectanglesRequest(
                          reportCharacterBoxes: true,
                          onResult: (results) => setState(() {
                            detectedTextRectangles = results.cast();
                          }),
                        ),
                        VisionDetectBarcodesRequest(
                          onResult: (results) => setState(() {
                            detectedBarcodes = results.cast();
                          }),
                        ),
                      ],
                    );
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
              );
            },
          ),
          ...[
            if (recognizedTexts != null)
              for (final text in recognizedTexts!) text.build(),
            if (detectedRectangles != null)
              for (final rect in detectedRectangles!) rect.build(),
            if (recognizedAnimals != null)
              for (final animal in recognizedAnimals!) animal.build(),
            if (detectedTextRectangles != null)
              for (final text in detectedTextRectangles!) text.build(),
            if (detectedBarcodes != null)
              for (final barcode in detectedBarcodes!) barcode.build(),
          ]
        ],
      ),
    );
  }
}
