import 'dart:math';
import 'dart:convert';

String generateRandomString(int length) {
  var rand = Random.secure();
  var bytes = List<int>.generate(length, (i) => rand.nextInt(256));
  return base64Url.encode(bytes);
}
