import './hash_algorithms/hash_algorithm.dart';
import './hash_algorithms/sha1.dart';



///Creates instances of implemented hash functions
class HashFunctionsFactory {
  ///Creates SHA-1 instance
  HashAlgorithm createSHA1() {
    return SHA1();
  }
}