import 'dart:io' as io;
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypt;
import 'package:flutter/foundation.dart';

import 'error/file_io_exception.dart';

extension FileExtensions on io.File {
  /// ファイルのSHA1を計算する.
  /// ファイル読み込み中に問題が発生した場合、io.Fileからの例外をそのまま投げる.
  Future<crypt.Digest> calculateSha1() async {
    return crypt.sha1.bind(openRead()).first;
  }

  /// ファイルのSHA256を計算する.
  /// ファイル読み込み中に問題が発生した場合、io.Fileからの例外をそのまま投げる.
  Future<crypt.Digest> calculateSha256() async {
    return crypt.sha256.bind(openRead()).first;
  }

  /// ファイルのSHA512を計算する.
  /// ファイル読み込み中に問題が発生した場合、io.Fileからの例外をそのまま投げる.
  Future<crypt.Digest> calculateSha512() async {
    return crypt.sha512.bind(openRead()).first;
  }

  /// ファイルのMD5を計算する.
  /// ファイル読み込み中に問題が発生した場合、io.Fileからの例外をそのまま投げる.
  Future<crypt.Digest> calculateMd5() async {
    return crypt.md5.bind(openRead()).first;
  }

  /// Dart SDKのFile書き込み不具合を避け、可能な限り確実にファイルを書き込む.
  ///
  /// 大容量ファイルの書き込みを分割チェックして行うため、適切な [blockSize] を指定する.
  ///
  /// NOTE.
  /// 書き込みの仕組み上、この処理は上書き保存のみをサポートする.
  /// 追記を確実に行いたい場合は別途確実性の高い手段を考えること.
  ///
  /// NOTE.
  /// 経験則として概ね1回目のリトライで書き込みは成功する.
  ///
  /// Dart SDK issue: https://github.com/dart-lang/sdk/issues/36087
  Future safeWriteBytes(
    Uint8List binary, {
    int blockSize = 1024 * 256,
    int retry = 10,
  }) async {
    Future<bool> writeImpl() async {
      // 既にファイルが存在していたら消す
      if (await exists()) {
        await delete();
      }
      var cursor = 0;
      try {
        final sink = await open(mode: io.FileMode.writeOnly);
        try {
          while (cursor < binary.length) {
            final length = min(blockSize, binary.length - cursor);
            await sink.writeFrom(binary, cursor, cursor + length);
            await Future<void>.delayed(const Duration(milliseconds: 1));
            await sink.flush();
            cursor += length;

            // ファイルの存在と長さをチェック
            if (!(await exists()) || (await this.length()) != cursor) {
              return false;
            }
          }
        } finally {
          await sink.close();
        }
      } on io.FileSystemException catch (e, stackTrace) {
        if (kDebugMode) {
          print('FileExtensions.safeWriteBytes() failed: $e');
          print(stackTrace);
        }
        return false;
      }
      return true;
    }

    // 失敗したのでリトライ
    for (var i = 0; i < (retry + 1); ++i) {
      if (await writeImpl()) {
        // 無事完了
        return;
      }
      debugPrint('Retry write[${i + 1}] -> $path');
    }
    throw FileIOException('Write failed: $path');
  }
}
