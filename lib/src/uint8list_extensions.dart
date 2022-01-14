import 'dart:typed_data';
import 'package:crypto/crypto.dart' as crypt;

extension Uint8ListExtensions on Uint8List {
  /// データのSHA1を計算する.
  crypt.Digest calculateSha1() {
    return crypt.sha1.convert(this);
  }

  /// データのSHA256を計算する.
  crypt.Digest calculateSha256() {
    return crypt.sha256.convert(this);
  }

  /// データのSHA512を計算する.
  crypt.Digest calculateSha512() {
    return crypt.sha512.convert(this);
  }

  /// データのMD5を計算する.
  crypt.Digest calculateMd5() {
    return crypt.md5.convert(this);
  }
}
