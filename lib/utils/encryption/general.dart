import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'fernet.dart';

enum EncryptionMethod { fernet }

class Encryption {
  static String encrypt(String text, String password, EncryptionMethod method) {
    var key = utf8.encode('falafi_hash_2023');
    var bytes = utf8.encode(password);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var passwd = hmacSha256.convert(bytes);

    // use different encryption methods
    switch (method) {
      case EncryptionMethod.fernet:
        return encryptFernet("$passwd", text);
      default:
        throw Exception("Unknown encryption method");
    }
  }

  static String decrypt(String text, String password, EncryptionMethod method) {
    var key = utf8.encode('falafi_hash_2023');
    var bytes = utf8.encode(password);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var passwd = hmacSha256.convert(bytes);

    switch (method) {
      case EncryptionMethod.fernet:
        return decryptFernet("$passwd", text);
      default:
        throw Exception("Unknown encryption method");
    }
  }
}
