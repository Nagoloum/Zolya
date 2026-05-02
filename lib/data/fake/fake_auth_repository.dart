import 'package:dartz/dartz.dart';
import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'fake_data.dart';

class FakeAuthRepository implements AuthRepository {
  Future<void> _latency() => Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, void>> sendOtp(String phone) async {
    await _latency();
    return const Right(null);
  }

  @override
  Future<Either<Failure, User>> verifyOtp(String phone, String code) async {
    await _latency();
    return Right(FakeData.currentUser);
  }

  @override
  Future<Either<Failure, User>> register({
    required String fullName,
    required String phone,
    required String password,
  }) async {
    await _latency();
    return Right(FakeData.currentUser.copyWith(fullName: fullName));
  }

  @override
  Future<Either<Failure, User>> login({required String phone, required String password}) async {
    await _latency();
    return Right(FakeData.currentUser);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await _latency();
    return const Right(null);
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    await _latency();
    return Right(FakeData.currentUser);
  }
}
