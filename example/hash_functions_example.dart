import 'dart:typed_data';

import 'package:hash_functions/hash_functions.dart';
import 'package:hash_functions/src/hash_algorithms/hash_algorithm.dart';

void main() {
  HashFunctionsFactory factory = HashFunctionsFactory();
  HashAlgorithm sha1 = factory.createSHA1();
  print('sha1 of "": ${sha1.process(Uint8List.fromList([]))}'); //sha1 of "": da39a3ee5e6b4b0d3255bfef95601890afd80709
}
