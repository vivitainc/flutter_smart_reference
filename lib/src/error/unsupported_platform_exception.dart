import 'runtime_exception.dart';

/// 実行中のPlatformで非対応な処理が実行された.
class UnsupportedPlatformException extends RuntimeException {
  UnsupportedPlatformException(String message) : super(message);
}
