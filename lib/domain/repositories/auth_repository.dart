import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendOtp(String phone);
  Future<Either<Failure, User>> verifyOtp(String phone, String code);
  Future<Either<Failure, User>> register({required String fullName, required String phone, required String password});
  Future<Either<Failure, User>> login({required String phone, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
}
