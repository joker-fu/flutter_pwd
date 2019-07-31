import 'dart:async';

import 'package:cipher2/cipher2.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';

class CryptoUtils {
  static Future<dynamic> encrypt(String content) async {
    return await Cipher2.encryptAesCbc128Padding7(
        content, Crypto.CRYPTO_AES_KEY, Crypto.CRYPTO_AES_IV);
  }

  static Future<dynamic> decrypt(String content) async {
    return await Cipher2.decryptAesCbc128Padding7(
        content, Crypto.CRYPTO_AES_KEY, Crypto.CRYPTO_AES_IV);
  }
}
