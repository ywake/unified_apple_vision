import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'extension/vision_request_type.dart';

late final String mobileNetV2Path;
late final String yoloV3Path;

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
    ..executionPriority = VisionExecutionPriority.high
    ..setLogLevel(VisionLogLevel.error);

  VisionRequestType selectedType = VisionRequestType.recognizeText;
  VisionResults? results;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    mobileNetV2Path = await _compileModel('assets/MobileNetV2.mlmodel');
    yoloV3Path = await _compileModel('assets/YOLOv3.mlmodel');
  }

  Future<String> _compileModel(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final pwd = await getTemporaryDirectory();
    final file = File('${pwd.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    ));
    return await _unifiedAppleVision.compileModel(
      file.path,
      VisionExecutionPriority.high,
    );
  }

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
                AwesomeCameraSwitchButton(state: state, scale: 1.0),
                Expanded(
                  child: DropdownMenu<VisionRequestType>(
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
