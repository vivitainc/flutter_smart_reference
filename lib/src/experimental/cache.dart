import 'package:semaphore/lock.dart';

import '../lock_extensions.dart';

/// キャッシュ処理をサポートするWrapper Object.
///
/// NOTE.
/// 設計として、キャッシュそれ自体をData Objectのequals対象としてはならない.
/// また、equals系は例外を吐いて終了する.
///
/// Cacheそれ自体をequals対象としたり、比較するのであれば、それはこのCache<T>を使用するユースケースではない.
/// また、dispose()等の解放を必要とする場合も、設計上適切に行うべきであるため、ユースケースではない.
class Cache<T> {
  late T _value;

  /// すでに値を生成済であればtrue.
  bool _hasValue = false;

  /// [getAsync] が利用されるさいの排他制御.
  Lock? _lock;

  @Deprecated('DO NOT ACCESS THIS')
  @override
  int get hashCode => throw Exception('Invalid access(equals)');

  @Deprecated('DO NOT ACCESS THIS')
  @override
  bool operator ==(Object other) => throw Exception('Invalid access(equals)');

  /// キャッシュを取得し、キャッシュが未生成であれば [lazy] 関数を通じてキャッシュを生成する.
  /// このメソッドは [getAsync] と排他仕様であり、同時に実行された場合の動作保証を行わない.
  T get(T Function() lazy) {
    if (!_hasValue) {
      _value = lazy();
      _hasValue = true;
    }
    return _value;
  }

  /// キャッシュを取得し、キャッシュが未生成であれば [lazy] 関数を通じてキャッシュを生成する.
  /// このメソッドは [get] と排他仕様であり、同時に実行された場合の動作保証を行わない.
  /// [withLock] がtrueの場合、内部では非同期の排他制御が行われる.
  Future<T> getAsync(Future<T> Function() lazy, {bool withLock = true}) {
    // 先行返却
    if (_hasValue) {
      return Future.value(_value);
    }

    // 生成関数.
    // Lock有無については [withLock] 引数をチェックする
    Future<T> lambda() async {
      if (_hasValue) {
        return _value;
      }

      _value = await lazy();
      _hasValue = true;
      return _value;
    }

    if (withLock) {
      _lock ??= Lock();
      return _lock!.withLock(lambda);
    } else {
      return lambda();
    }
  }

  @Deprecated('DO NOT ACCESS THIS')
  @override
  String toString() => throw Exception('Invalid access(equals)');
}
