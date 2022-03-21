import 'package:flutter_test/flutter_test.dart';
import 'package:smart_reference/smart_reference.dart';

void main() {
  test('release', () {
    var disposed = false;
    final ref = SmartReference.wrap(
      reference: 100,
      dispose: (value) {
        disposed = true;
      },
    );

    ref.addRef(); // ref == 2;
    expect(disposed, false);
    ref.release(); // ref == 1;
    expect(disposed, false);
    ref.release(); // ref == 0;
    expect(disposed, true);
  });
}
