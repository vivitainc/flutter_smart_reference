import 'package:runtime_assert/runtime_assert.dart';

/// C++のsmart_ptrに相当する参照カウンタ付きオブジェクトを管理する.
///
/// 参照を追加する際に [addRef] をコールし、
/// 参照を手放す際に [release] をコールする.
///
/// [SmartReference.wrap] をコールした時点で参照カウンタは1であるため、
/// 最初の参照保持では改めて [addRef] をコールする必要はない.
class SmartReference<T> {
  /// 対象オブジェクト
  T _reference;

  var _count = 1;

  /// 解放関数
  final void Function(T reference) _dispose;

  /// 参照カウンタ付きオブジェクトを生成する.
  factory SmartReference.wrap({
    required T reference,
    required void Function(T reference) dispose,
  }) {
    return SmartReference._(reference, dispose);
  }

  SmartReference._(this._reference, this._dispose);

  @override
  int get hashCode => _reference.hashCode ^ _count.hashCode ^ _dispose.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is SmartReference<T> &&
        other._reference == _reference &&
        other._count == _count &&
        other._dispose == _dispose;
  }

  /// 参照カウンタを増やす
  void addRef() {
    check(_count > 0, 'Invalid reference count');
    ++_count;
  }

  /// オブジェクトが生きていれば参照を取得する
  T get() {
    check(_count > 0, 'Invalid reference count');
    return _reference;
  }

  /// オブジェクトが生きていれば参照を取得し、それ以外であればnullを返却する
  T? getOrNull() {
    if (_count == 0) {
      return null;
    } else {
      return _reference;
    }
  }

  /// 掴んでいる参照を削除する
  void release() {
    check(_count > 0, 'Invalid reference count');
    --_count;
    if (_count == 0) {
      _dispose(_reference);
    }
  }
}
