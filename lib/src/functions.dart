/// 指定型にCastできる場合はキャストし、それ以外はnullを返却する.
/// これはKotlinの `as?` 構文の代替として用意される.
T? asOrNull<T>(final dynamic value) {
  if (value is T) {
    return value;
  } else {
    return null;
  }
}

/// Future<void>.delayed()の糖衣構文.
Future delayed(final Duration duration) => Future<void>.delayed(duration);

/// NOP命令（No Operation)を発行する.
/// この命令はDart実行ループの1イテレーションをSkipしたい場合等に使用する.
Future nop() => delayed(Duration.zero);
