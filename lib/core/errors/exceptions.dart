class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException($statusCode): $message';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'Pas de connexion internet'});

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});

  @override
  String toString() => 'AuthException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;
  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class PaymentException implements Exception {
  final String message;
  const PaymentException({required this.message});

  @override
  String toString() => 'PaymentException: $message';
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException({required this.message});

  @override
  String toString() => 'NotFoundException: $message';
}
