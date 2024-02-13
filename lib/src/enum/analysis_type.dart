enum AnalysisType {
  recognizeText,
  ;

  String get key => switch (this) {
        AnalysisType.recognizeText => 'recognize_text',
      };
}
