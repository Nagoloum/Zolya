import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/auth/send_otp_usecase.dart';
import '../../../domain/usecases/auth/verify_otp_usecase.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtp;
  final VerifyOtpUseCase verifyOtp;
  final LoginUseCase login;
  final RegisterUseCase register;
  final AuthRepository authRepository;

  AuthBloc({
    required this.sendOtp,
    required this.verifyOtp,
    required this.login,
    required this.register,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheckAuth);
    on<AuthSendOtpRequested>(_onSendOtp);
    on<AuthVerifyOtpRequested>(_onVerifyOtp);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onCheckAuth(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => user != null ? emit(AuthAuthenticated(user: user)) : emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onSendOtp(AuthSendOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await sendOtp(SendOtpParams(phone: event.phone));
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (_) => emit(AuthOtpSent(phone: event.phone)),
    );
  }

  Future<void> _onVerifyOtp(AuthVerifyOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await verifyOtp(VerifyOtpParams(phone: event.phone, code: event.code));
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await login(LoginParams(phone: event.phone, password: event.password));
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await register(RegisterParams(
      fullName: event.fullName,
      phone: event.phone,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthOtpSent(phone: event.phone)),
    );
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
