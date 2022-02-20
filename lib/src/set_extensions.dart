extension SetCopyWhere<T> on Set<T> {
  /// [test] がtrueを返却したElementを使用して新たなコピーを返却する.
  ///
  /// 1件も一致しない場合、返却値は空Listとなる.
  /// 全件一致した場合でも `copy` という関数名の文脈を優先し、コピーインスタンスを返却する.
  Set<T> copyWhere(bool Function(T element) test) {
    final result = <T>{};
    for (final element in this) {
      if (test(element)) {
        result.add(element);
      }
    }
    return result;
  }
}

extension SetCopyWithAddElement<T> on Set<T> {
  /// Listに新たな要素を末尾へ加えたコピーを作成する.
  Set<T> copyWithAddElement(T element) {
    // コピーを行う
    final copied = {...this};
    copied.add(element);
    return copied;
  }
}

extension SetIterableFlatten<T> on Iterable<Set<T>> {
  /// SetのListを1つのSetにまとめる.
  Set<T> flatten() {
    final result = <T>{};
    // ignore: prefer_foreach
    for (final set in this) {
      result.addAll(set);
    }
    return result;
  }
}
