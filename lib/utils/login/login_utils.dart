import 'dart:convert';

import 'package:crypto/crypto.dart';

class LoginUtils {

  static Digest encodePassword(String pwd) {
    final List<int> bytes = utf8.encode(pwd);
    final Digest digest = sha256.convert(bytes);
    return digest;
  }

}
