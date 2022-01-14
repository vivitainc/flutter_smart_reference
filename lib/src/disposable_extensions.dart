import 'disposable.dart';

extension DisposableExtensions<T extends Disposable> on T {
  /// body()実行後、this.dispose()を自動的にコールする.
  T2 use<T2>(T2 Function(T value) body) {
    try {
      return body(this);
    } finally {
      dispose();
    }
  }

  /// await body()実行後、this.dispose()を自動的にコールする.
  Future<T2> useAsync<T2>(Future<T2> Function(T value) body) async {
    try {
      return await body(this);
    } finally {
      dispose();
    }
  }
}
