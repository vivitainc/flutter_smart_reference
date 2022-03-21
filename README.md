[![Github Actions](https://github.com/vivitainc/flutter_smart_reference/actions/workflows/flutter-package-test.yaml/badge.svg)](https://github.com/vivitainc/flutter_smart_reference/actions/workflows/flutter-package-test.yaml)

## Features

参照カウンタ付きオブジェクトを保持する.

## Usage

```dart
var disposed = false;
final ref = SmartReference.wrap(
    reference: 100,
    dispose: (value) {
        disposed = true;
    },
);

ref.addRef(); // ref == 2;
ref.release(); // ref == 1;
ref.release(); // ref == 0, call dispose();
```
