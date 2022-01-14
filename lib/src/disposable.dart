/// 解放処理が必要なオブジェクト.
abstract class Disposable {
  /// 管理しているリソースを開放する.
  void dispose();
}
