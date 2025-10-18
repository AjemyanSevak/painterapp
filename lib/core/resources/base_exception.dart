import 'package:firebase_core/firebase_core.dart';

class BaseException implements Exception {
  // Status Codes.
  static const connectionError = 'internet_connection_error';
  static const unknownError = 'unknown_error';
  static const serverError = 'server_error';
  static const authenticationError = 'authentication_error';
  static const invalidCredentialsError = 'invalid_credentials';

  // API Status Codes.
  static const unauthorized = '401';
  static const notFound = '404';
  static const internalServerError = '500';

  final String? message;

  final String? code;

  final dynamic error;

  BaseException({this.message, this.code, this.error});

  @override
  String toString() {
    if (error == null) return 'Exception';
    return 'Exception: $error';
  }

  factory BaseException.fromJson(final Map<String, dynamic> json) {
    return BaseException(message: json['message'], code: json['code']);
  }
  factory BaseException.fromFirebase(final FirebaseException e) {
    return BaseException(message: e.message, code: e.code);
  }

  factory BaseException.serverException() {
    return BaseException(message: 'Server Error', code: serverError);
  }

  factory BaseException.internetConnectionException() {
    return BaseException(
      message: 'Internet Connection Error',
      code: connectionError,
    );
  }

  factory BaseException.unknown() {
    return BaseException(message: 'Unknown problem', code: unknownError);
  }

  factory BaseException.authentication() {
    return BaseException(
      message: 'Authentication error',
      code: authenticationError,
    );
  }

  factory BaseException.invalidCredentials() {
    return BaseException(
      message: 'Invalid credentials',
      code: invalidCredentialsError,
    );
  }
}
