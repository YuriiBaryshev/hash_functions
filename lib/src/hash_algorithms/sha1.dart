import 'dart:typed_data';
import 'package:hash_functions/src/hash_algorithms/hash_algorithm.dart';


///Implements SHA-1 algorithm
class SHA1 extends HashAlgorithm {
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
}