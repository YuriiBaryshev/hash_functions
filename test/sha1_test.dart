import 'dart:typed_data';

import 'package:hash_functions/hash_functions.dart';
import 'package:test/test.dart';
import 'package:pointycastle/pointycastle.dart' show Digest;

void main() {
  group('SHA-1 implementation tests', () {
    final SHA1 sha1 = SHA1();


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


    test('processing test vectors', () {
      Uint8List data = Uint8List.fromList([0x61, 0x62, 0x63]);
      Uint8List hash = Uint8List.fromList([
        0xa9, 0x99, 0x3e, 0x36, 0x47, 0x06, 0x81, 0x6a,
        0xba, 0x3e, 0x25, 0x71, 0x78, 0x50, 0xc2, 0x6c,
        0x9c, 0xd0, 0xd8, 0x9d
      ]);
      expect(sha1.process(data), hash);
    });
    
    
    test('output comparison with pointycastle lib', () {
      final sha1PC = Digest("SHA-1"); //SHA-1 implementation from PointyCastle lib

      List<int> intData = [];
      for(int i = 0; i < 256; i++) {
        intData.add(i);
      }
      Uint8List data = Uint8List.fromList(intData);
      expect(sha1PC.process(data), sha1.process(data));

      intData = [];
      for(int i = 0; i < 1024; i++) {
        intData.add(i);
      }
      data = Uint8List.fromList(intData);
      expect(sha1PC.process(data), sha1.process(data));

      intData = [];
      for(int i = 0; i < 2048; i++) {
        intData.add(i);
      }
      data = Uint8List.fromList(intData);
      expect(sha1PC.process(data), sha1.process(data));
    });


    test('performance comparison test', () {
      final sha1PC = Digest("SHA-1"); //SHA-1 implementation from PointyCastle lib

      List<int> intData = List.filled(1000000, 0);
      Uint8List data = Uint8List.fromList(intData);
      final stopwatch = Stopwatch();
      stopwatch.start();
      sha1PC.process(data);
      stopwatch.stop();
      int timePC = stopwatch.elapsedTicks;

      stopwatch.reset();
      stopwatch.start();
      sha1.process(data);
      stopwatch.stop();
      int timeThisLib = stopwatch.elapsedTicks;

      print("Pointycastle lib SHA-1 implementation time in ticks is $timePC");
      print("This lib SHA-1 implementation time in ticks is $timeThisLib");
    });
  });
}