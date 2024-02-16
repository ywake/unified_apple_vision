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
                  final input =
                      VisionInputImage(bytes: image.bytes, size: image.size);
                  try {
                    final start = DateTime.now();
                    _unifiedAppleVision.analyze(input, [
                      const VisionRecognizeTextRequest(),
                      const VisionDetectRectanglesRequest(maxObservations: 0),
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
            if (results?.trackObjects != null)
              for (final object in results!.trackObjects!) object.build(),
            if (results?.trackRectangles != null)
              for (final rect in results!.trackRectangles!) rect.build(),
          ]
        ],
      ),
    );
  }
}

extension VisionRecognizedTextObservationEx on VisionRecognizedTextObservation {
  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _Painter(this),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final VisionRecognizedTextObservation recognizedText;

  _Painter(this.recognizedText);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the bounding box
    final rect = recognizedText.scale(size).reverse(Offset(0, size.height));
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);

    // Draw top-left corner
    final cornerPaint = Paint()..style = PaintingStyle.fill;
    canvas.drawCircle(rect.topLeft, 3, cornerPaint..color = Colors.red);

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
    textPainter.paint(canvas, rect.topLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

extension VisionRectangleEx on VisionRectangleObservation {
  VisionRectangleObservation reverse(Offset offset) {
    abs(Offset offset) => Offset(offset.dx.abs(), offset.dy.abs());

    return copyWith(
      topLeft: abs(offset - topLeft),
      topRight: abs(offset - topRight),
      bottomLeft: abs(offset - bottomLeft),
      bottomRight: abs(offset - bottomRight),
    );
  }

  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _RectanglePainter(this),
      ),
    );
  }
}

class _RectanglePainter extends CustomPainter {
  final VisionRectangleObservation rectangle;

  _RectanglePainter(this.rectangle);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = rectangle.scale(size).reverse(Offset(0, size.height));
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

extension VisionDetectedObjectObservationEx on VisionDetectedObjectObservation {
  Widget build() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ObjectPainter(this),
      ),
    );
  }
}

class _ObjectPainter extends CustomPainter {
  final VisionDetectedObjectObservation object;

  _ObjectPainter(this.object);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = object.boundingBox;
    final path = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..lineTo(rect.topRight.dx, rect.topRight.dy)
      ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy)
      ..lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
