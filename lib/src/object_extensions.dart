extension ObjectExtensions<T> on T {
  /// Kotlin.also相当の処理を行う.
  /// thisをclosureに渡し、処理後にthisを再度返却する.
  T also(void Function(T value) closure) {
    closure(this);
    return this;
  }

  /// Kotlin.also相当の処理を行う.
  /// thisをclosureに渡し、処理後にthisを再度返却する.
  T2 let<T2>(T2 Function(T value) closure) {
    return closure(this);
  }
}
