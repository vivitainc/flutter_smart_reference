import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypt;

extension Uint8ListCalculateMd5 on Uint8List {
  /// データのMD5を計算する.
  crypt.Digest calculateMd5() {
    return crypt.md5.convert(this);
  }
}

extension Uint8ListCalculateSha1 on Uint8List {
  /// データのSHA1を計算する.
  crypt.Digest calculateSha1() {
    return crypt.sha1.convert(this);
  }
}

extension Uint8ListCalculateSha256 on Uint8List {
  /// データのSHA256を計算する.
  crypt.Digest calculateSha256() {
    return crypt.sha256.convert(this);
  }
}

extension Uint8ListCalculateSha512 on Uint8List {
  /// データのSHA512を計算する.
  crypt.Digest calculateSha512() {
    return crypt.sha512.convert(this);
  }
}
