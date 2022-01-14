import 'package:semaphore/lock.dart';

extension LockExtension on Lock {
  /// 引数の[block]実行前後にLockの取得・開放を行うラッパー関数.
  /// これはKotlinのLock.withLock()と同等の処理を行う.
  Future<T> withLock<T>(Future<T> Function() block) async {
    await acquire();
    try {
      return await block();
    } finally {
      release();
    }
  }
}
