This is pure Dart lib which implements hash functions

## Features

1. HashFunctionsFactory ability to create relevant instance
2. SHA-1 implementation

Additionally output similarity and performance comparision with PointyCasle lib implementation is performed

## Getting started

1. Install Dart SDK and Flutter framework.
2. Install IDE (this was developed using Android studio, but any Dart-supporting will do).
3. Run command flutter test in project's folder in order to see that every thing is alright (all tests passed).

## Usage

```dart
  HashFunctionsFactory factory = HashFunctionsFactory();
  HashAlgorithm sha1 = factory.createSHA1();
  Uint8List hashValue = sha1.process(Uint8List.fromList([0, 1, 2, 3]));
```
