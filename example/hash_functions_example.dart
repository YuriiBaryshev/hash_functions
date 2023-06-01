import 'dart:typed_data';

import 'package:hash_functions/hash_functions.dart';
import 'package:hash_functions/src/hash_algorithms/hash_algorithm.dart';

void main() {
  HashFunctionsFactory factory = HashFunctionsFactory();
  HashAlgorithm sha1 = factory.createSHA1();
  print('sha1 of "[0x61, 0x62, 0x63]": '
      '${sha1.process(Uint8List.fromList([0x61, 0x62, 0x63]))}'
  ); //sha1 of "[169, 153, 62, 54, 71, 6, 129, 106, 186, 62, 37, 113, 120, 80, 194, 108, 156, 208, 216, 157]"
}
