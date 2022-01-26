import 'dart:io' as io;

import 'package:flutter/foundation.dart';

class Environments {
  Environments._();

  /// FlutterのUnitTest($ flutter test)として実行中であればtrueを返却する.
  static bool get isFlutterTesting =>
      !kIsWeb && io.Platform.environment.containsKey('FLUTTER_TEST');
}
