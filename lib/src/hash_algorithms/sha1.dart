import 'dart:typed_data';
import 'package:hash_functions/src/hash_algorithms/hash_algorithm.dart';


///Implements SHA-1 algorithm
class SHA1 extends HashAlgorithm {
  List<int> k = List.filled(80, 0);

  SHA1() {
    for(int i = 0; i < 80; i++) {
      if(i < 20) {
        k[i] = 0x5A827999;
      } else {
        if(i < 40) {
          k[i] = 0x6ED9EBA1;
        } else {
          if(i < 60) {
           k[i] = 0x8F1BBCDC;
          } else {
            k[i] = 0xCA62C1D6;
          }
        }
      }
    }
  }


  ///Hashing data re-initialising hashing state
  @override
  Uint8List process(Uint8List data) {
    List<int> h = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    data = pad(data);
    for(int i = 0; i < data.length; i += 0x40) {
        List<int> w = List.filled(80, 0);
        int t = 0;
        for(; t < 16; t++) {
          w[t] = data[(t << 2) + i] << 24 | data[(t << 2) + i + 1] << 16 |
            data[(t << 2) + i + 2] << 8 | data[(t << 2) + i + 3];
        }

        for(t = 16; t < 80; t++) {
          w[t] = w[t-3] ^ w[t-8] ^ w[t-14] ^ w[t-16];
          w[t] = _circularLeftShiftFor32Bit(w[t], 1);
        }

        int a = h[0], b = h[1], c = h[2], d = h[3], e = h[4];
        int temp = 0;
        for(t = 0; t < 80; t++) {
          temp =(_circularLeftShiftFor32Bit(a, 5) + _f(b, c, d, t)) & 0xffffffff;
          temp = (temp + e) & 0xffffffff;
          temp = (temp + w[t]) & 0xffffffff;
          temp = (temp + k[t]) & 0xffffffff;
          e = d;
          d = c;
          c = _circularLeftShiftFor32Bit(b, 30);
          b = a;
          a = temp;
        }
        h[0] = (h[0] + a) & 0xffffffff;
        h[1] = (h[1] + b) & 0xffffffff;
        h[2] = (h[2] + c) & 0xffffffff;
        h[3] = (h[3] + d) & 0xffffffff;
        h[4] = (h[4] + e) & 0xffffffff;

    }
    Uint8List hashValue = Uint8List.fromList(List.filled(20, 0));
    for(int i = 0, distance = 24; i < 4; i++, distance -= 8) {
      hashValue[i] = h[0] >> distance;
      hashValue[i + 4] = h[1] >> distance;
      hashValue[i + 8] = h[2] >> distance;
      hashValue[i + 12] = h[3] >> distance;
      hashValue[i + 16] = h[4] >> distance;
    }
    return hashValue;
  }


  ///Pads data with standardised Merkle-Damgard enhanced construction
  Uint8List pad(Uint8List data) {
    BigInt originalLengthInBits = BigInt.from(data.length) << 3;

    List<int> paddedData = [];
    paddedData.addAll(data);
    paddedData.add(0x80); //append '1'
    paddedData.addAll(List.filled(56 - (paddedData.length & 0x3f), 0));

    String hexInterpretationOfBitsLen = originalLengthInBits.toRadixString(16);
    hexInterpretationOfBitsLen = hexInterpretationOfBitsLen.padLeft(16, '0');

    for(int i = 0; i < 16; i += 2) {
      paddedData.add(int.parse(hexInterpretationOfBitsLen.substring(i, i+2), radix: 16));
    }
    return Uint8List.fromList(paddedData);
  }


  //SHA-1 primitives
  int _circularLeftShiftFor32Bit(int number, int distance) {
    return ((number << distance) | (number >> 32 - distance)) & 0xffffffff;
  }


  int _f(int b, int c, int d, int iteration) {
    int output;
    if(iteration < 20) {
      output = (b & c) | ((~b) & d);
    } else {
      if(iteration < 40) {
        output = b ^ c ^ d;
      } else {
        if(iteration < 60) {
          output = (b & c) | (b & d) | (c & d);
        } else {
          output = b ^ c ^ d;
        }
      }
    }

    return output;
  }
}