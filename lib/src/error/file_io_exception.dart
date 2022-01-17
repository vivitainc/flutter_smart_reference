import 'dart:io';

/// ファイルの読み書きに失敗した.
class FileIOException implements IOException {
  final String message;
  FileIOException(this.message);
}
