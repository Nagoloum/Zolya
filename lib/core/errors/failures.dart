import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required super.message, this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Pas de connexion internet'});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  const ValidationFailure({required super.message, this.fieldErrors});
}

class PaymentFailure extends Failure {
  const PaymentFailure({required super.message});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'Une erreur inattendue s\'est produite'});
}
