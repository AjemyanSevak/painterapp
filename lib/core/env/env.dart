import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  AppEnvironment._();

  static const _kBaseURL = 'BASE_URL';

  static String get baseURL => _getString(_kBaseURL);

  static String _getString(String key) {
    final envValue = dotenv.env[key];

    if (envValue != null && envValue.trim().isNotEmpty) {
      return envValue;
    }

    throw Exception('Undefined config: $key');
  }

  // static int _getInt(String key) {
  //   final envValue = dotenv.env[key];

  //   if (envValue != null && envValue.trim().isNotEmpty) {
  //     return int.parse(envValue);
  //   }

  //   throw Exception('Undefined config: $key');
  // }

  // static bool _getBoolean(String key) {
  //   final envValue = dotenv.env[key];

  //   if (envValue != null && envValue.trim().isNotEmpty) {
  //     return envValue == 'true';
  //   }

  //   throw Exception('Undefined config: $key');
  // }

  static bool _isEveryDefined() {
    final envKeys = <String>[
      ...[_kBaseURL],
    ];

    return dotenv.isEveryDefined(envKeys);
  }

  static Future<AppEnvironment> init() async {
    const envFile = '.env';

    try {
      await dotenv.load(fileName: envFile);
    } catch (e) {
      debugPrint(e.toString());
    }

    if (!_isEveryDefined()) {
      throw UnimplementedError('Please add missing configrations to $envFile file.');
    }

    return AppEnvironment._();
  }
}
