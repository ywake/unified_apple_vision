import 'dart:math';

class UniqueId implements Comparable<UniqueId> {
  static int _counter = 0;
  static final _rand = Random();

  final String value;
  UniqueId(this.value);
  factory UniqueId.gen() {
    final time = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final count = _counter.toRadixString(36);
    _counter++;
    final rand = _rand.nextInt(pow(36, 4).toInt()).toRadixString(36);
    return UniqueId('${time}_${count}_$rand');
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    return other is UniqueId && value == other.value;
  }

  @override
  int compareTo(UniqueId other) {
    return value.compareTo(other.value);
  }

  @override
  String toString() {
    return value;
  }
}
