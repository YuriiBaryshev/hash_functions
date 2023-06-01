import 'package:hash_functions/hash_functions.dart';
import 'package:test/test.dart';

void main() {
  group('Hash function factory tests', () {
    final HashFunctionsFactory factory = HashFunctionsFactory();

    setUp(() {
      // Additional setup goes here.
    });

    test('creates SHA1', () {
      expect(() => factory.createSHA1(), returnsNormally);
    });
  });
}
