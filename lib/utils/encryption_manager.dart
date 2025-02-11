import 'dart:convert';

import 'package:chat_sdk/utils/logger.dart';
import 'package:encrypt/encrypt.dart';

/// AES256Encryption class is used to encrypt and decrypt the data using AES-256 encryption.
class EncryptionManager {
  /// Default constructor
  EncryptionManager({required this.aesSecretKey});

  ///  aesSecretKey is the secret key used for AES-256 encryption.
  final String aesSecretKey;

  /// ivSize is the size of the Initialization Vector (IV) in bytes.
  static const int ivSize = 12;

  /// Encrypts the given plain text using the given key.
  String? encrypt(String plainText, {Key? key}) {
    try {
      final decodedKey = base64Decode(aesSecretKey);
      // Generate a random IV (Initialization Vector)
      final iv = IV.fromSecureRandom(ivSize);

      // Create an AES encrypter with the key and IV
      final cipher = Encrypter(AES(key ?? Key(decodedKey), mode: AESMode.gcm));

      // Encrypt the plaintext using AES-GCM
      final encrypted = cipher.encrypt(plainText, iv: iv);

      // Combine the IV and encrypted bytes into a single byte array
      final combined = iv.bytes + encrypted.bytes;

      // Encode the combined byte array into a Base64 string and return
      return base64Encode(combined);
    } on Object catch (e) {
      'AES256Encryption - Error while encrypt: $e'.logE;
      return '';
    }
  }

  /// Decrypts the given encrypted text using the given key.
  String? decrypt(String encryptedText, {Key? key}) {
    if (encryptedText.isEmpty) return encryptedText;
    try {
      // Decode the Base64-encoded encrypted text into a byte array
      final encryptedData = base64Decode(
        encryptedText.replaceAll(RegExp(r'\s'), ''),
      );

      // Extract the IV (Initialization Vector) from the encrypted data
      final iv = IV(encryptedData.sublist(0, ivSize));

      // Extract the encrypted bytes (excluding the IV) from the encrypted data
      final encrypted = encryptedData.sublist(ivSize);

      // Convert the key into bytes and pad it to 32 bytes
      final myKey = base64Decode(aesSecretKey);

      // Create an AES decrypter with the key and IV
      final cipher = Encrypter(AES(key ?? Key(myKey), mode: AESMode.gcm));

      // Decrypt the encrypted bytes using AES-GCM
      return cipher.decrypt(Encrypted(encrypted), iv: iv);
    } on Object catch (e) {
      'AES256Encryption - Error while decrypt: $e text: $encryptedText'.logE;
      return '';
    }
  }
}
