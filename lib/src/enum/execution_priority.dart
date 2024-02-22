/// Compatible with quality of service (QoS) when running DispatchQueue
enum VisionExecutionPriority {
  veryHigh('userInteractive'),
  high('userInitiated'),
  normal('default'),
  low('utility'),
  veryLow('background'),
  unspecified('unspecified'),
  ;

  final String qos;
  const VisionExecutionPriority(this.qos);
}
