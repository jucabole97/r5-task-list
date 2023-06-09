import 'dart:convert';
import 'package:crypto/crypto.dart';

class TextUtils {
  static String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hashedBytes = sha256.convert(bytes);
    return hashedBytes.toString();
  }

  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.)+[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }
}
