extension MapExtensions<K, V> on Map<K, V> {
  /// [test] 関数がtrueを最初に返却したEntryを返却する.
  MapEntry<K, V>? firstWhere(bool Function(MapEntry<K, V> entry) test) {
    for (final kv in entries) {
      if (test(kv)) {
        return kv;
      }
    }
    return null;
  }

  /// [test] 関数がtrueを返却した [MapEntry<K, V>] をすべて返却する.
  Iterable<MapEntry<K, V>> where(bool Function(MapEntry<K, V> entry) test) {
    return entries.where(test);
  }

  /// Mapの内容の一部を変更したコピーオブジェクトを生成する.
  /// Keyが存在しない場合、 builder(origin) にはnullが渡される.
  /// 全件一致した場合でも `copy` という関数名の文脈を優先し、コピーインスタンスを返却する.
  Map<K, V> copyWithApplyElement(
    K key,
    V Function(Map<K, V> map, V? origin) builder,
  ) {
    final oldValue = this[key];
    final newValue = builder(this, oldValue);
    final copied = {...this};
    copied[key] = newValue;
    return copied;
  }

  /// データをコピーし、コピー後に [newValues] をマージして返却する.
  /// 同じKeyが存在する場合、後勝ちとなる.
  Map<K, V> copyWithMerge(Map<K, V> newValues) {
    final copied = {...this};
    for (final kv in newValues.entries) {
      copied[kv.key] = kv.value;
    }
    return copied;
  }

  /// [test] がtrueを返却したMapEntryを使用して新たなコピーを返却する.
  ///
  /// 1件も一致しない場合、返却値は空Mapとなる.
  /// 全件一致した場合でも `copy` という関数名の文脈を優先し、コピーインスタンスを返却する.
  Map<K, V> copyWhere(bool Function(MapEntry<K, V> entry) test) {
    final result = <K, V>{};
    for (final element in entries) {
      if (test(element)) {
        result[element.key] = element.value;
      }
    }
    return result;
  }

  /// [keys] にKeyが含まれている要素のみを抽出してコピーする.
  ///
  /// 1件も一致しない場合、返却値は空Mapとなる.
  /// 全件一致した場合でも `copy` という関数名の文脈を優先し、コピーインスタンスを返却する.
  Map<K, V> copyWhereKeys(Set<K> keys) {
    return copyWhere((e) => keys.contains(e.key));
  }
}
