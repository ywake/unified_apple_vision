import 'dart:convert';
import 'dart:typed_data';

extension StringEx on String {
  Uint8List decodeBase64() => base64Decode(this);

  T toEnum<T>(List<T> values) {
    return values.firstWhere(
      (e) => e.toString().split('.').last == this,
      orElse: () => throw ArgumentError('Invalid enum value: $this'),
    );
  }
}
