import 'package:logger/logger.dart';

enum VisionLogLevel {
  none(Level.off),
  error(Level.error),
  warning(Level.warning),
  info(Level.info),
  debug(Level.debug),
  ;

  final Level loggerLevel;
  const VisionLogLevel(this.loggerLevel);
}
