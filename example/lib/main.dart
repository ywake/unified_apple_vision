import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'extension/vision_request_type.dart';

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

  VisionRequestType selectedType = VisionRequestType.recognizeText;
  VisionResults? results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraAwesomeBuilder.awesome(
            saveConfig: SaveConfig.photo(),
            imageAnalysisConfig: AnalysisConfig(maxFramesPerSecond: 1),
            topActionsBuilder: (state) => AwesomeTopActions(
              state: state,
              children: [
                const Spacer(),
                DropdownMenu<VisionRequestType>(
                  initialSelection: selectedType,
                  onSelected: (value) => setState(() {
                    results = null;
                    if (value != null) selectedType = value;
                  }),
                  dropdownMenuEntries: [
                    for (final type in VisionRequestType.values)
                      type.dropdownMenuEntry,
                  ],
                ),
              ],
            ),
            middleContentBuilder: (_) => const SizedBox(),
            bottomActionsBuilder: (_) => const SizedBox(),
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
                      requests: selectedType.requests(
                        (res) => setState(() => results = res),
                      ),
                    );
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
              );
            },
          ),
          ...?selectedType.widgets(results),
        ],
      ),
    );
  }
}
