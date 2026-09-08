/// Shared JSON decoding helpers.
abstract final class JsonParsers {
  static double asDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    throw FormatException('Expected a number, got $value');
  }

  static int asInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    throw FormatException('Expected an integer, got $value');
  }
}
