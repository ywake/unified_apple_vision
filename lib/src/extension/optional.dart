extension OptionalEx<T> on T? {
  R? maybe<R>(R Function(T) f) => this == null ? null : f(this as T);
}
