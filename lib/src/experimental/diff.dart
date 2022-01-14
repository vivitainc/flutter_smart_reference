import 'diff_type.dart';

/// ある特定MapやListの差分を定義する.
class Diff<T> {
  /// 差分オブジェクト
  final T entry;

  /// 差分種別
  final DiffType type;

  const Diff._(this.entry, this.type);

  @override
  int get hashCode => entry.hashCode ^ type.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Diff<T> && other.entry == entry && other.type == type;
  }

  /// 2つのマップの前後差分を取得する.
  /// 差分が無いとき、返却は空リストである.
  /// .type [DiffType.add], [DiffType.remove], [DiffType.valueChanged]
  static List<Diff<MapEntry<K, V>>> fromMap<K, V>({
    required Map<K, V> before,
    required Map<K, V> after,
  }) {
    final result = <Diff<MapEntry<K, V>>>[];

    for (final afterEntry in after.entries) {
      if (!before.containsKey(afterEntry.key)) {
        // 前のデータに存在しないので、追加された
        result.add(Diff._(afterEntry, DiffType.add));
      } else if (before[afterEntry.key] != afterEntry.value) {
        // 差分が発生している
        result.add(Diff._(afterEntry, DiffType.valueChanged));
      }
    }

    for (final beforeEntry in before.entries) {
      if (!after.containsKey(beforeEntry.key)) {
        // 後のデータに存在しないので、削除された
        result.add(Diff._(beforeEntry, DiffType.remove));
      }
    }

    return result;
  }

  /// 2つのCollectionの前後差分を取得する.
  /// 差分が無いとき、返却は空リストである.
  /// .type [DiffType.add], [DiffType.remove], [DiffType.valueChanged]
  static List<Diff<T>> fromSet<T>({
    required Set<T> before,
    required Set<T> after,
  }) {
    final result = <Diff<T>>[];

    // 追加された要素を探す
    for (final afterEntry in after) {
      if (!before.contains(afterEntry)) {
        // beforeに含まれないので追加されている
        result.add(Diff._(afterEntry, DiffType.add));
      }
    }

    // 削除された要素を探す
    for (final beforeEntry in before) {
      if (!after.contains(beforeEntry)) {
        // afterに含まれないので削除されている
        result.add(Diff._(beforeEntry, DiffType.remove));
      }
    }

    return result;
  }
}
