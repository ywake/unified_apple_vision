import 'dart:convert';
import 'dart:typed_data';

class Json {
  final Map<String, dynamic> data;

  Json(this.data);

  factory Json.fromString(String payload) {
    final json = jsonDecode(payload);
    return Json(json);
  }

  @override
  String toString() {
    return data.toString();
  }

  /// Generic value fetcher that throws a detailed exception if a required key is missing.
  T? _value<T>(String key, bool require) {
    final value = data[key] as T?;
    if (require && value == null) {
      throw Exception('There is no $key in Json');
    }
    return value;
  }

  /// Fetches a boolean value for [key]. Throws an exception if [key] is not found.
  bool bool_(String key) => _value<bool>(key, true)!;

  /// Optionally fetches a boolean value for [key], returning null if [key] is not found.
  bool? boolOr(String key) => _value<bool>(key, false);

  /// Fetches a String value for [key]. Throws an exception if [key] is not found or not a String.
  String str(String key) => _value<String>(key, true)!;

  /// Optionally fetches a String value for [key], returning null if [key] is not found or not a String.
  String? strOr(String key) => _value<String>(key, false);

  /// Fetches an int value for [key] and converts it. Throws an exception if [key] is not found.
  int int_(String key) => (_value<num>(key, true)!).toInt();

  /// Optionally fetches an int value for [key] and converts it, returning null if [key] is not found.
  int? integerOr(String key) => (_value<num>(key, false))?.toInt();

  /// Fetches a double value for [key] and converts it. Throws an exception if [key] is not found.
  double double_(String key) => (_value<num>(key, true)!).toDouble();

  /// Optionally fetches a double value for [key] and converts it, returning null if [key] is not found.
  double? doubleOr(String key) => (_value<num>(key, false))?.toDouble();

  /// Fetches a list value for [key]. Throws an exception if [key] is not found.
  ///
  /// This method uses `List.cast<T>()` to convert the list to the desired type.
  /// If you want to use a list of a specific type, use `listObj<T>()` instead.
  List<T> list<T>(String key) => _value<List>(key, true)!.cast<T>();

  /// Optionally fetches a list value for [key], returning null if [key] is not found.
  ///
  /// This method uses `List.cast<T>()` to convert the list to the desired type.
  /// If you want to use a list of a specific type, use `objList<T>()` instead.
  List<T>? listOr<T>(String key) => _value<List>(key, false)?.cast<T>();

  Json? _json(String key, bool require) {
    final map = _value<Map<String, dynamic>>(key, require);
    return map != null ? Json(map) : null;
  }

  /// Fetches a Json value for [key]. Throws an exception if [key] is not found.
  Json json(String key) => _json(key, true)!;

  /// Optionally fetches a Json value for [key], returning null if [key] is not found.
  Json? jsonOr(String key) => _json(key, false);

  List<Json>? _jsonList(String key, bool require) {
    final list = _value<List>(key, require);
    return list?.map((e) => Json(e)).toList();
  }

  /// Fetches a list of Json values for [key]. Throws an exception if [key] is not found.
  List<Json> jsonList(String key) => _jsonList(key, true)!;

  /// Optionally fetches a list of Json values for [key], returning null if [key] is not found.
  List<Json>? jsonListOr(String key) => _jsonList(key, false);

  T? _obj<T>(String key, T Function(Json) fromJson, bool require) {
    final json = _json(key, require);
    return json == null ? null : fromJson(json);
  }

  /// Fetches an object for [key]. Throws an exception if [key] is not found.
  T obj<T>(String key, T Function(Json) fromJson) => _obj(key, fromJson, true)!;

  /// Optionally fetches an object for [key], returning null if [key] is not found.
  T? objOr<T>(String key, T Function(Json) fromJson) =>
      _obj(key, fromJson, false);

  List<T>? _objList<T>(String key, T Function(Json) fromJson, bool require) {
    final list = _jsonList(key, require);
    return list?.map((e) => fromJson(e)).toList();
  }

  /// Fetches a list of objects for [key]. Throws an exception if [key] is not found.
  ///
  /// The [fromJson] function is used to convert the Json to the desired object.
  List<T> objList<T>(String key, T Function(Json) fromJson) =>
      _objList(key, fromJson, true)!;

  /// Optionally fetches a list of objects for [key], returning an empty list if [key] is not found.
  ///
  /// The [fromJson] function is used to convert the Json to the desired object.
  List<T>? objListOr<T>(String key, T Function(Json) fromJson) =>
      _objList(key, fromJson, false);

  T? _enum<T>(String key, List<T> values, bool require) {
    final s = _value<String>(key, require);
    return s != null
        ? values.firstWhere((e) => '$e'.split('.').last == s,
            orElse: () => throw Exception('{$key: $s} is not in the enum list'))
        : null;
  }

  /// Fetches an enum value for [key]. Throws an exception if [key] is not found.
  ///
  /// The [values] list must contain the enum values.
  /// The method will throw an exception if the value is not found in the [values] list.
  T enum_<T>(String key, List<T> values) => _enum(key, values, true)!;

  /// Optionally fetches an enum value for [key], returning null if [key] is not found.
  ///
  /// The [values] list must contain the enum values.
  /// The method will return null if the value is not found in the [values] list.
  T? enumOr<T>(String key, List<T> values) => _enum(key, values, false);

  Uint8List? _bytes(String key, bool require) {
    final s = _value<String>(key, require);
    return s != null ? base64Decode(s) : null;
  }

  /// Fetches a base64 encoded bytes value for [key]. Throws an exception if [key] is not found.
  Uint8List bytes(String key) => _bytes(key, true)!;

  /// Optionally fetches a base64 encoded bytes value for [key], returning null if [key] is not found.
  Uint8List? bytesOr(String key) => _bytes(key, false);
}

extension MapEx on Map<String, dynamic> {
  // _Map<Object?, Object?>
  static Map<String, dynamic> fromResponse(dynamic response) {
    final map = (response as Map).map((key, value) {
      final strKey = key as String;
      if (value is Map) {
        return MapEntry(strKey, MapEx.fromResponse(value));
      }
      return MapEntry(strKey, value);
    });
    return map;
  }
}
