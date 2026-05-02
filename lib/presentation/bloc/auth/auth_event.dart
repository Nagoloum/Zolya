import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthSendOtpRequested extends AuthEvent {
  final String phone;
  AuthSendOtpRequested({required this.phone});
  @override List<Object?> get props => [phone];
}

class AuthVerifyOtpRequested extends AuthEvent {
  final String phone;
  final String code;
  AuthVerifyOtpRequested({required this.phone, required this.code});
  @override List<Object?> get props => [phone, code];
}

class AuthLoginRequested extends AuthEvent {
  final String phone;
  final String password;
  AuthLoginRequested({required this.phone, required this.password});
  @override List<Object?> get props => [phone, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String fullName;
  final String phone;
  final String password;
  AuthRegisterRequested({required this.fullName, required this.phone, required this.password});
  @override List<Object?> get props => [fullName, phone, password];
}

class AuthLogoutRequested extends AuthEvent {}
