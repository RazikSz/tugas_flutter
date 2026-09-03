import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const String _keyToken = 'day33_auth_token';

  // In-memory global variable for quick synchronous access & fallback
  static String? currentToken;

  // Persistent secure storage with multiplatform support
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    wOptions: WindowsOptions(),
    webOptions: WebOptions(dbName: 'day33_db', publicKey: 'day33_key'),
  );

  /// Simpan token ke storage dan variabel global
  static Future<void> saveToken(String token) async {
    currentToken = token;
    try {
      await _storage.write(key: _keyToken, value: token);
    } catch (e) {
      log('TokenStorage saveToken warning: $e (token kept in memory)');
    }
  }

  /// Ambil token dari variabel global atau storage jika belum di-cache
  static Future<String?> getToken() async {
    if (currentToken != null && currentToken!.isNotEmpty) {
      return currentToken;
    }
    try {
      final storedToken = await _storage.read(key: _keyToken);
      currentToken = storedToken;
      return storedToken;
    } catch (e) {
      log('TokenStorage getToken warning: $e');
      return currentToken;
    }
  }

  /// Hapus token saat logout
  static Future<void> clearToken() async {
    currentToken = null;
    try {
      await _storage.delete(key: _keyToken);
    } catch (e) {
      log('TokenStorage clearToken warning: $e');
    }
  }

  /// Cek apakah user sudah terotentikasi
  static Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return currentToken != null && currentToken!.isNotEmpty;
    }
  }
}
