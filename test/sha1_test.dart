import 'dart:typed_data';

import 'package:hash_functions/hash_functions.dart';
import 'package:test/test.dart';

void main() {
  group('SHA-1 implementation tests', () {
    final SHA1 sha1 = SHA1();;

    setUp(() {
      // Additional setup goes here.
    });

    test('creates proper message padding', () {
      Uint8List data = Uint8List.fromList([0x61, 0x62, 0x63, 0x64, 0x65]);
      Uint8List paddedData = Uint8List.fromList([
        0x61, 0x62, 0x63, 0x64, 0x65, 0x80, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0x28,
      ]);
      expect(sha1.pad(data), paddedData);
    });
  });
}