enum VisionExecutionPriority {
  high('high'),
  medium('medium'),
  low('low'),
  lowest('background'),
  ;

  final String taskPriority;
  const VisionExecutionPriority(this.taskPriority);
}
