extension IntExtensions on int {
  /// 16進数の値に変換する.
  ///
  /// 戻り値は必ず小文字である。そのため、 `FF` のような大文字を期待する場合、upperCase等で変換を行うこと.
  String toHexString() {
    String result;
    if (this < 0) {
      // Dart2.12時点では負の値を期待したHexに変換できない
      // BigIntを経由する.
      // issue: https://github.com/dart-lang/sdk/issues/36807
      result = BigInt.from(this).toUnsigned(32).toRadixString(16);
    } else {
      result = toRadixString(16);
    }
    if (result.length.isEven) {
      return result;
    } else {
      return '0$result';
    }
  }
}
