import 'dart:math';

class CommonUtils {
  static randomString(int length) {
    const _randomChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    final rand = Random();

    final codeUnits = List.generate(length, (index) => _randomChars.codeUnitAt(rand.nextInt(_randomChars.length)));
    return String.fromCharCodes(codeUnits);
  }
}
