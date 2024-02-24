enum VisionExecutionPriority {
  high('high'),
  medium('medium'),
  low('low'),
  veryLow('background'),
  ;

  final String taskPriority;
  const VisionExecutionPriority(this.taskPriority);
}
