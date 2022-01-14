import 'dart:io' as io;

class Environments {
  Environments._();

  /// FlutterのUnitTest($ flutter test)として実行中であればtrueを返却する.
  static bool get isFlutterTesting =>
      io.Platform.environment.containsKey('FLUTTER_TEST');
}
