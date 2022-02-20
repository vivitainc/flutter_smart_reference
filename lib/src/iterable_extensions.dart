extension IterableFind<T> on Iterable<T> {
  /// 指定条件で検索し、発見できなければnullを返却する
  T? find(bool Function(T element) test) {
    for (final e in this) {
      if (test(e)) {
        return e;
      }
    }
    return null;
  }
}

extension IterableIterableFlattenList<T> on Iterable<Iterable<T>> {
  /// SetのListを1つのSetにまとめる.
  List<T> flattenList() {
    final result = <T>[];
    // ignore: prefer_foreach
    for (final list in this) {
      result.addAll(list);
    }
    return result;
  }
}

extension IterableIterableFlattenSet<T> on Iterable<Iterable<T>> {
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

extension IterableToListOrNullEmpty<T> on Iterable<T> {
  /// Iteratorの要素数が1以上の場合にListへ変換し、Emptyであればnullに変換する
  List<T>? toListOrNullEmpty() {
    if (isEmpty) {
      return null;
    } else {
      return toList();
    }
  }
}

extension IterableToSetOrNullEmpty<T> on Iterable<T> {
  /// Iteratorの要素数が1以上の場合にListへ変換し、Emptyであればnullに変換する
  Set<T>? toSetOrNullEmpty() {
    if (isEmpty) {
      return null;
    } else {
      return toSet();
    }
  }
}

extension IterableWhereNonNull<T> on Iterable<T> {
  /// NonNullのみを取得する
  Iterable<T2> whereNonNull<T2>() {
    return where((element) => element != null).map((e) => e! as T2);
  }
}

extension MapEntryIterableToMap<K, V> on Iterable<MapEntry<K, V>> {
  /// ListからMapへ変換する
  Map<K, V> toMap() {
    final result = <K, V>{};
    result.addEntries(this);
    return result;
  }
}
