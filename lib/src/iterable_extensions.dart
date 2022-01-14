extension IterableExtensions<T> on Iterable<T> {
  /// 指定条件で検索し、発見できなければnullを返却する
  T? find(bool Function(T element) test) {
    for (final e in this) {
      if (test(e)) {
        return e;
      }
    }
    return null;
  }

  /// NonNullのみを取得する
  Iterable<T2> whereNonNull<T2>() {
    return where((element) => element != null).map((e) => e! as T2);
  }

  /// Iteratorの要素数が1以上の場合にListへ変換し、Emptyであればnullに変換する
  List<T>? toListOrNullEmpty() {
    if (isEmpty) {
      return null;
    } else {
      return toList();
    }
  }

  /// Iteratorの要素数が1以上の場合にListへ変換し、Emptyであればnullに変換する
  Set<T>? toSetOrNullEmpty() {
    if (isEmpty) {
      return null;
    } else {
      return toSet();
    }
  }
}

extension MapEntryIterableExtensions<K, V> on Iterable<MapEntry<K, V>> {
  /// ListからMapへ変換する
  Map<K, V> toMap() {
    final result = <K, V>{};
    result.addEntries(this);
    return result;
  }
}

extension IterableIterableExtensions<T> on Iterable<Iterable<T>> {
  /// SetのListを1つのSetにまとめる.
  List<T> flattenList() {
    final result = <T>[];
    // ignore: prefer_foreach
    for (final list in this) {
      result.addAll(list);
    }
    return result;
  }

  /// SetのListを1つのSetにまとめる.
  Set<T> flattenSet() {
    final result = <T>{};
    // ignore: prefer_foreach
    for (final set in this) {
      result.addAll(set);
    }
    return result;
  }
}
