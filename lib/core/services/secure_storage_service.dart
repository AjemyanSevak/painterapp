import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final secureStorage = const FlutterSecureStorage();

  Future<void> writeToken(final String value) async {
    await secureStorage.write(key: 'token', value: value);
  }

  Future<String?> readToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'token');
  }

  Future<void> writeLocale(final String locale) async {
    await secureStorage.write(key: 'locale', value: locale);
  }

  Future<Locale?> readLocale() async {
    final locale = await secureStorage.read(key: 'locale');

    return locale != null ? Locale(locale) : null;
  }

  Future<void> deleteLocale() async {
    await secureStorage.delete(key: 'locale');
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }
}
