import 'dart:typed_data';


///Determines methods mandatory for the hash algorithms implemented in this
///package. It must be a parent class for all hash algorithms implementation
abstract class HashAlgorithm {
  ///Hashes inputted data in order to return hash value (aka digit)
  Uint8List process(Uint8List data);
}