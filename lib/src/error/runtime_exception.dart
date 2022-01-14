/// Basic exception impl.
class RuntimeException implements Exception {
  final String message;

  RuntimeException(this.message);

  @override
  String toString() {
    // ignore: no_runtimetype_tostring
    return '$runtimeType{message: $message}';
  }
}
