import 'package:flutter_test/flutter_test.dart';
import 'package:stdlib_plus/src/int_extensions.dart';

Future main() async {
  test('toHexString()', () {
    expect(0.toHexString(), equals('00'));
    expect(255.toHexString(), equals('ff'));
    expect((-1).toHexString(), equals('ffffffff'));
    expect(256.toHexString(), equals('0100'));
  });
}
