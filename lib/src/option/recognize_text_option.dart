import 'dart:ui';

import 'package:unified_apple_vision/src/enum/text_recognition_level.dart';

class VisionRecognizeTextOption {
  /// The minimum height, relative to the image height, of the text to recognize.
  final double? minimumTextHeight;

  /// A value that determines whether the request prioritizes accuracy or speed in text recognition.
  /// Default is [VisionTextRecognitionLevel.accurate]
  final VisionTextRecognitionLevel? recognitionLevel;

  /// A Boolean value that indicates whether to attempt detecting the language to use the appropriate model for recognition and language correction.
  /// Default is false
  /// Available in iOS 16.0+, macOS 13.0+.
  final bool? automaticallyDetectsLanguage;

  /// An array of languages to detect, in priority order.
  final List<Locale>? recognitionLanguages;

  /// A Boolean value that indicates whether the request applies language correction during the recognition process.
  /// Disabling this property returns the raw recognition results, which provides performance benefits but less accurate results.
  /// If [customWords] is not null, this value will be set to true.
  final bool? usesLanguageCorrection;

  /// An array of strings to supplement the recognized languages at the word-recognition stage.
  /// Custom words take precedence over the standard lexicon. The request ignores this value if [usesLanguageCorrection] is false.
  /// So if this value is not null, [usesLanguageCorrection] will be set to true
  final List<String>? customWords;

  /// The maximum number of candidates to be returned for each word.
  final int maxCandidates;

  const VisionRecognizeTextOption({
    this.minimumTextHeight,
    this.recognitionLevel,
    this.automaticallyDetectsLanguage,
    this.recognitionLanguages,
    this.usesLanguageCorrection,
    this.customWords,
    this.maxCandidates = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'minimum_text_height': minimumTextHeight,
      'recognition_level': recognitionLevel?.name,
      'automatically_detects_language': automaticallyDetectsLanguage,
      'recognition_languages': recognitionLanguages?.map((e) => e.toLanguageTag()).toList(),
      'uses_language_correction': customWords == null ? usesLanguageCorrection : true,
      'custom_words': customWords,
      'max_candidates': maxCandidates,
    };
  }
}
