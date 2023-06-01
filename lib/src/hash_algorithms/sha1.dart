import 'dart:typed_data';
import 'package:hash_functions/src/hash_algorithms/hash_algorithm.dart';


///Implements SHA-1 algorithm
class SHA1 extends HashAlgorithm {
  List<int> k = List.filled(80, 0);

  SHA1() {
    for(int i = 0; i < 80; i++) {
      if(i < 20) {
        k[i] = 0xA827999;
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
    // TODO: implement process
    throw UnimplementedError();
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
    return (number << distance) | (number >> 32 - distance) & 0xffffffff;
  }


  int _f(int b, int c, int d, int iteration) {
    int output;
    if(iteration < 20) {
      output = (b & c) | (~b & d);
    } else {
      if(iteration < 40) {
        output = b ^ c ^ d;
      } else {
        if(iteration < 60) {
          output = (b & c) | (b & d) | (c & d);
        } else {
          output = output = b ^ c ^ d;
        }
      }
    }

    return output;
  }
}