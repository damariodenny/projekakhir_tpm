import 'package:crypto/crypto.dart';
import 'dart:convert';

class EncryptionService {
  Future<String> encrypt(String input) async {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
