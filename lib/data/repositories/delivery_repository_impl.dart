import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../domain/entities/delivery.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../models/delivery_model.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final ApiClient apiClient;

  DeliveryRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Delivery>>> getAvailableDeliveries() async {
    try {
      final response = await apiClient.get(ApiEndpoints.availableDeliveries);
      final list = (response.data['data'] as List)
          .map((e) => DeliveryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Delivery>>> getMyDeliveries() async {
    try {
      final response = await apiClient.get(ApiEndpoints.deliveries, queryParameters: {'mine': true});
      final list = (response.data['data'] as List)
          .map((e) => DeliveryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Delivery>> acceptDelivery(String deliveryId) async {
    try {
      final response = await apiClient.post(ApiEndpoints.acceptDelivery(deliveryId));
      return Right(DeliveryModel.fromJson(response.data as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Delivery>> updateStatus(String deliveryId, DeliveryStatus status) async {
    try {
      final response = await apiClient.patch(
        ApiEndpoints.updateDeliveryStatus(deliveryId),
        data: {'status': status.name},
      );
      return Right(DeliveryModel.fromJson(response.data as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getWeeklyEarnings() async {
    try {
      final response = await apiClient.get(ApiEndpoints.delivererEarnings);
      return Right(response.data['weekly_earnings'] as int);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
