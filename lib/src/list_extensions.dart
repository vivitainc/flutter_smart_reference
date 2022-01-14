extension ListExtensions<T> on List<T> {
  /// Listの一部を変更したコピーオブジェクトを生成する.
  /// ListのIndexが存在しない場合、I/Oできないので例外を投げる.
  List<T> copyWithApplyElement(
    int index,
    T Function(List<T> list, T origin) builder,
  ) {
    final oldValue = this[index];
    final newValue = builder(this, oldValue);

    // コピーを行う
    final copied = [...this];
    copied[index] = newValue;
    return copied;
  }

  /// Listに新たな要素を末尾へ加えたコピーを作成する.
  List<T> copyWithAddElement(T element) {
    // コピーを行う
    final copied = [...this, element];
    return copied;
  }

  /// [test] がtrueを返却したElementを使用して新たなコピーを返却する.
  ///
  /// 1件も一致しない場合、返却値は空Listとなる.
  /// 全件一致した場合でも `copy` という関数名の文脈を優先し、コピーインスタンスを返却する.
  List<T> copyWhere(bool Function(T element) test) {
    final result = <T>[];
    for (final element in this) {
      if (test(element)) {
        result.add(element);
      }
    }
    return result;
  }
}

extension ListIterableExtensions<T> on Iterable<List<T>> {
  /// SetのListを1つのSetにまとめる.
  List<T> flatten() {
    final result = <T>[];
    // ignore: prefer_foreach
    for (final list in this) {
      result.addAll(list);
    }
    return result;
  }
}
