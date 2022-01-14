import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

/// Stream操作関数の糖衣構文
class Streams {
  Streams._();

  /// Tuple2への型指定を省略してStreamのcombineを行う
  static CombineLatestStream<dynamic, Tuple2<T1, T2>> combineLatest2<T1, T2>(
      Stream<T1> a, Stream<T2> b) {
    return CombineLatestStream.combine2(
      a,
      b,
      (a, b) => Tuple2<T1, T2>(a as T1, b as T2),
    );
  }

  /// Tuple3への型指定を省略してStreamのcombineを行う
  static CombineLatestStream<dynamic, Tuple3<T1, T2, T3>>
      combineLatest3<T1, T2, T3>(
    Stream<T1> a,
    Stream<T2> b,
    Stream<T3> c,
  ) {
    return CombineLatestStream.combine3(
      a,
      b,
      c,
      (a, b, c) => Tuple3(a as T1, b as T2, c as T3),
    );
  }
}
