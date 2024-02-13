import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

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
    ..xcodeLogLevel = VisionLogLevel.none
    ..executionPriority = VisionExecutionPriority.veryHigh
    ..request = [
      const VisionRecognizeTextRequest(automaticallyDetectsLanguage: true),
    ];

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
                    size: Size(image.width.toDouble(), image.height.toDouble()),
                  );
                  try {
                    _unifiedAppleVision.analyze(input).then((res) {
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
            if (results?.recognizedTexts != null)
              for (final text in results!.recognizedTexts!) text.build(),
          ]
        ],
      ),
    );
  }
}

extension VisionRecognizedTextEx on VisionRecognizedText {
  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _Painter(this),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final VisionRecognizedText recognizedText;

  _Painter(this.recognizedText);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the bounding box
    final coord =
        recognizedText.rectangle.scale(size).reverse(Offset(0, size.height));
    final path = Path()
      ..moveTo(coord.topLeft.dx, coord.topLeft.dy)
      ..lineTo(coord.topRight.dx, coord.topRight.dy)
      ..lineTo(coord.bottomRight.dx, coord.bottomRight.dy)
      ..lineTo(coord.bottomLeft.dx, coord.bottomLeft.dy)
      ..lineTo(coord.topLeft.dx, coord.topLeft.dy);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);

    // Draw top-left corner
    final cornerPaint = Paint()..style = PaintingStyle.fill;
    canvas.drawCircle(coord.topLeft, 3, cornerPaint..color = Colors.red);

    // Draw the text
    final candidate = recognizedText.candidates.first;
    final text = candidate.text;
    final confidence = candidate.confidence;
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$text (${confidence.toStringAsFixed(1)})',
        style: const TextStyle(fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, coord.topLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

extension VisionRectangleEx on VisionRectangle {
  VisionRectangle reverse(Offset offset) {
    abs(Offset offset) => Offset(offset.dx.abs(), offset.dy.abs());

    return VisionRectangle(
      topLeft: abs(offset - topLeft),
      topRight: abs(offset - topRight),
      bottomLeft: abs(offset - bottomLeft),
      bottomRight: abs(offset - bottomRight),
    );
  }
}
