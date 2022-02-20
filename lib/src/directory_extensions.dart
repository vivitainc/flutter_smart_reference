import 'dart:io' as io;

extension IoDirectoryTryDelete on io.Directory {
  /// ディレクトリの削除を試す。成功した場合はtrue, そうでない場合はfalseを返却する.
  /// 既に削除されている場合は成功とみなし、trueを返却する.
  Future<bool> tryDelete({required bool recursive}) async {
    try {
      if (!await exists()) {
        return true;
      }
      await delete(recursive: recursive);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
