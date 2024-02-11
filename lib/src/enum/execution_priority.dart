/// Compatible with quality of service (QoS) when running DispatchQueue
enum VisionExecutionPriority {
  veryHigh,
  high,
  normal,
  low,
  veryLow,
  unspecified,
  ;

  String get qos {
    switch (this) {
      case VisionExecutionPriority.veryHigh:
        return 'userInteractive';
      case VisionExecutionPriority.high:
        return 'userInitiated';
      case VisionExecutionPriority.normal:
        return 'default';
      case VisionExecutionPriority.low:
        return 'utility';
      case VisionExecutionPriority.veryLow:
        return 'background';
      case VisionExecutionPriority.unspecified:
      default:
        return 'unspecified';
    }
  }
}
