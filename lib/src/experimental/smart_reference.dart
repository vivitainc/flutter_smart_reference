import '../assertion.dart';
import '../disposable.dart';

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
  final void Function(T reference) _release;

  /// 参照カウンタ付きオブジェクトを生成する.
  factory SmartReference.wrap({
    required T reference,
    required void Function(T reference) release,
  }) {
    return SmartReference._(reference, release);
  }

  SmartReference._(this._reference, this._release);

  @override
  int get hashCode => _reference.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is SmartReference<T> && other._reference == _reference;
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
      _release(_reference);
    }
  }

  /// Disposableオブジェクトをwrapする
  static SmartReference<T2> disposable<T2 extends Disposable>(T2 reference) {
    return SmartReference<T2>._(
      reference,
      (reference) => reference.dispose(),
    );
  }
}
