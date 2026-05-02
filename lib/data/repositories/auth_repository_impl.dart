import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, void>> sendOtp(String phone) async {
    try {
      await apiClient.post(ApiEndpoints.sendOtp, data: {'phone': phone});
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(String phone, String code) async {
    try {
      final response = await apiClient.post(ApiEndpoints.verifyOtp, data: {'phone': phone, 'code': code});
      final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> register({required String fullName, required String phone, required String password}) async {
    try {
      final response = await apiClient.post(ApiEndpoints.register, data: {
        'full_name': fullName,
        'phone': phone,
        'password': password,
      });
      final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login({required String phone, required String password}) async {
    try {
      final response = await apiClient.post(ApiEndpoints.login, data: {'phone': phone, 'password': password});
      final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await apiClient.post(ApiEndpoints.logout);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final response = await apiClient.get(ApiEndpoints.me);
      final user = UserModel.fromJson(response.data as Map<String, dynamic>);
      return Right(user);
    } on ServerException catch (e) {
      if (e.statusCode == 401) return const Right(null);
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
